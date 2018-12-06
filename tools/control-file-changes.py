#!/usr/bin/python
# -*- coding:utf-8 -*-
# Copyright 2018 Android Development Tools @ Google

"""Pre-upload hook to check that set of changed files contains only
files from the set of allowed files or folders.
"""

import argparse
import sys
from textwrap import fill

def get_parser():
    """Return a command line parser."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--changed-files',
                        nargs='+',
                        help='List of changed files')
    parser.add_argument('--allowed-files',
                        nargs='+',
                        help='List of allowed files and folders')
    parser.add_argument('--reason',
                        help='A reason for the files not to be changed')

    return parser

def print_error_message(files, reason):
    ending = "s" if len(files) > 1 else ""
    files_list = '\n'.join(files)
    print("The commit you are trying to upload contains file{0}:\n{1}\n".format(ending, files_list))
    subject = "these files" if len(files) > 1 else "this file"
    message = "However, {0} should not be changed because {1}".format(subject, reason)
    print(fill(message, 80, break_on_hyphens=False) + "\n\n")

def main():
    """The main entry."""
    parser = get_parser()
    opts = parser.parse_args()

    changed_files = opts.changed_files
    allowed_files = opts.allowed_files
    reported_files = []
    for changed_file in changed_files:
        if not any(changed_file.startswith(allowed_file) for allowed_file in allowed_files):
            reported_files.append(changed_file)

    if reported_files:
        print_error_message(reported_files, opts.reason)
        return 1

    return 0

if __name__ == '__main__':
    sys.exit(main())
