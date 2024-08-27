#!/usr/bin/env python3
# Copyright 2016 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Wrapper to run google-java-format to check for any malformatted changes."""

import argparse
import os
import sys
from shutil import which

_path = os.path.realpath(__file__ + '/../..')
if sys.path[0] != _path:
    sys.path.insert(0, _path)
del _path

# We have to import our local modules after the sys.path tweak.  We can't use
# relative imports because this is an executable program, not a module.
# pylint: disable=wrong-import-position
import rh.shell # pylint: disable=import-error
import rh.utils # pylint: disable=import-error


def get_parser():
    """Return a command line parser."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--google-java-format', default='google-java-format',
                        help='The path of the google-java-format executable.')
    parser.add_argument('--google-java-format-diff',
                        default='google-java-format-diff.py',
                        help='The path of the google-java-format-diff script.')
    parser.add_argument('--fix', action='store_true',
                        help='Fix any formatting errors automatically.')
    parser.add_argument('--commit', type=str, default='HEAD',
                        help='Specify the commit to validate.')
    # While the formatter defaults to sorting imports, in the Android codebase,
    # the standard import order doesn't match the formatter's, so flip the
    # default to not sort imports, while letting callers override as desired.
    parser.add_argument('--sort-imports', action='store_true',
                        help='If true, imports will be sorted.')
    parser.add_argument('files', nargs='*',
                        help='If specified, only consider differences in '
                             'these files.')
    parser.add_argument('--verbose', action='store_true',
                        help='Explain what is being done.')
    return parser


def main(argv):
    """The main entry."""
    parser = get_parser()
    opts = parser.parse_args(argv)

    format_path = which(opts.google_java_format)
    if not format_path:
        print(
            f'Unable to find google-java-format at: {opts.google_java_format}',
            file=sys.stderr
        )
        return 1

    # TODO: Delegate to the tool once this issue is resolved:
    # https://github.com/google/google-java-format/issues/107
    diff_cmd = ['git', 'diff', '--no-ext-diff', '-U0', f'{opts.commit}^!']
    diff_cmd.extend(['--'] + opts.files)
    diff = rh.utils.run(diff_cmd, capture_output=True).stdout

    format_cmd = [
    	opts.google_java_format_diff,
    	'-p1',
    	'--aosp',
    	'-b',
    	format_path,
    ]
    if opts.fix:
        format_cmd.extend(['-i'])
    if not opts.sort_imports:
        format_cmd.extend(['--skip-sorting-imports'])

    format_cmd_result = rh.utils.run(
    	format_cmd, input=diff, capture_output=True)

    if format_cmd_result.returncode != 0:
        print("Failed due to non-zero exit code.")
        if opts.verbose:
            # print out the full command that was called, including pipes
            print("Called:")
            print(f"    {' '.join(diff_cmd)} |")
            print(f"    {' '.join(format_cmd)}")
        for line in format_cmd_result.stdout.splitlines():
            print(f"[captured stdout]   {line}")
        for line in format_cmd_result.stderr.splitlines():
            print(f"[captured stderr]   {line}")
        return format_cmd_result.returncode
    if format_cmd_result.stdout:
        print('One or more files in your commit have Java formatting errors.')
        print(f'You can run: {sys.argv[0]} --fix {rh.shell.cmd_to_str(argv)}')
        return 1
    if format_cmd_result.stderr:
        # We need to use stderr to catch errors in google-java-format since we
        # cannot listen for a non-zero error code until
        # https://github.com/google/google-java-format/pull/848 is merged.
        print("Errors have been captured in stderr.")
        for line in format_cmd_result.stderr.splitlines():
            print(f"[captured stderr]   {line}")
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
