#!/usr/bin/python
# -*- coding:utf-8 -*-
# Copyright 2017 Android Development Tools @ Google

"""Pre-upload hook to check if any changes are being made to IDEA inspection
profiles, and make sure changes in one profile are reflected in the other.
There is a notion of 'subset' and 'superset' profile. The hook will check
that every inspection enabled in subset profile is also enabled in superset
profile, and has the same settings. If instructed, the superset profile will
also be edited automatically to fix inconsistencies the found inconsistencies
by replicating the elements.

Common use case: Sync the inspection profile used locally in the IDE and
the one used on presubmit queue. One would normally want the presubmit profile
to be a subset of the IDE profile, so that all the issues which PSQ would
highlight were visible in the IDE in the first place.
"""

from __future__ import print_function

import argparse
import os
import sys
import traceback
import copy

from xml.etree import ElementTree as etree

# tools/repohooks isn't a package in Python sense, so need to patch PYTHONPATH
# to include rh.* in order to be able to import useful utils from there.
_path = os.path.realpath(__file__ + '/../..')
if sys.path[0] != _path:
    sys.path.insert(0, _path)
del _path

import rh.shell
import rh.utils
import rh.git

def get_parser():
    """Return a command line parser."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--superset-profile',
                        help='The path to the superset profile.')
    parser.add_argument('--subset-profile',
                        help='The path to the subset profile.')
    parser.add_argument('--fix', action='store_true',
                        help='Fix the inconsistencies automatically (superset '
                             'profile will need to be re-added and '
                             're-committed)')
    parser.add_argument('--commit', type=str, default='HEAD',
                        help='Commit currently being checked. In case of '
                             'automatic invocation, hook is called once for '
                             'each of the uploaded commits, so the ID is to '
                             'passed via this parameter.')

    return parser


def are_equal(e1, e2):
    # compare the tag name and the name/value attribute dicts
    if e1.tag != e2.tag or e1.attrib != e2.attrib:
      return False

    # compare child elements recursively
    if len(e1) != len(e2):
      return False

    return all(are_equal(c1, c2) for c1, c2 in zip(e1, e2))


def main(argv):
    """The main entry."""
    parser = get_parser()
    opts = parser.parse_args(argv)

    superset_profile_path = opts.superset_profile
    subset_profile_path = opts.subset_profile

    # We demand each commit to conform, so that git history contained only
    # valid commits and any revert would leave the profiles in a consistent
    # state.
    commit = opts.commit

    needs_validation = False
    diff_files = rh.git.get_affected_files(commit)
    for f in diff_files:
      if f.file == subset_profile_path or f.file == superset_profile_path:
        needs_validation = True

    if not needs_validation:
      return 0

    try:
      print("Parsing subset profile: {0}".format(subset_profile_path))
      subset_profile_xml = rh.git.get_file_content(commit,
                                                   subset_profile_path)
      subset_profile_root = etree.fromstring(subset_profile_xml)
      print("OK")
      print("Parsing superset profile: {0}".format(superset_profile_path))
      superset_profile_xml = rh.git.get_file_content(commit,
                                                     superset_profile_path)
      superset_profile_root = etree.fromstring(superset_profile_xml)
      print("OK")
    except:
      traceback.print_exc()
      return 1

    # Store the elements from the subset profile in a dict for easy access
    inspections_root = subset_profile_root.find('profile[@version="1.0"]')
    if inspections_root is None:
      print('Unrecognized XML structure or profile schema version when parsing '
            'subset profile. Expected schema version: 1.0. Consider updating '
            'the profiles parsing code in the hook.\n')
      return 1

    subset_inspections = {}
    for inspection in inspections_root.findall('inspection_tool'):
      if inspection.get('enabled') == 'true':
        subset_inspections[inspection.get('class')] = inspection

    # Now go through the superset profile and see if any of the elements differ,
    # replacing them in-place with a deep copy of the corresponding element from
    # the subset profile. Also delete everything we encounter from the dict to
    # see the remainder and append it to the end (normally the remainder should
    # be empty as IntelliJ stores every inspection in the inspection profile,
    # just setting true/false on them).
    inspections_root = superset_profile_root.find('profile[@version="1.0"]')
    if inspections_root is None:
      print('Unrecognized XML structure or profile schema version when parsing '
            'superset profile. Expected schema version: 1.0. Consider updating '
            'the profiles parsing code in the hook.\n')
      return 1

    diffs = []
    for i, inspection in enumerate(inspections_root.findall(
              'profile[@version="1.0"]/inspection_tool')):
      c = inspection.get('class')
      e = subset_inspections.get(c, None)
      if e is not None:
        if not are_equal(e, inspection):
          diffs.append(c)
          inspections_root.remove(inspection)
          inspections_root.insert(i, copy.deepcopy(e))
          del subset_inspections[c]

    absent = []
    for c, e in subset_inspections.iteritems():
      absent.append(c)
      inspections_root.append(e)

    # Dump the new profile instead of the existing one
    if diffs:
      print(
        "The following inspections from the superset profile did not match "
        "their settings in the subset profile:\n\n{0}\n\n".format(
          '\n'.join(diffs))
      )
    if absent:
      print(
        "The following inspections were absent in the superset profile "
        "altogether (are both profiles saved with the same version of "
        "IntelliJ?):\n\n{0}\n\n".format('\n'.join(absent))
      )

    if diffs or absent:
      if opts.fix:
        print("Applying fixes automatically...")
        root = rh.git.find_repo_root(path=__file__)
        git_project = os.environ.get('REPO_PATH', None)
        if git_project is None:
          print("Failed: REPO_PATH environment variable is expected to contain "
                "git project path, but it is not set. This is most likely the "
                "hook framework problem. Consider fixing it or disabling.\n")
          return 1
        full_superset_profile_path = os.path.join(root, git_project,
                                                  superset_profile_path)
        with open(full_superset_profile_path, 'wb') as f:
          f.write(etree.tostring(superset_profile_root))
        print("Fixes applied. In order to proceed with upload, please re-add "
              "and re-commit the superset profile: {0}\n".format(
          full_superset_profile_path))
      else:
        print(
          "The superset inspections profile does not contain everything from "
          "the subset inspections profile. You can run the hook with --fix "
          "to amend the superset profile in place.\n"
        )

      return 1

    return 0

if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
