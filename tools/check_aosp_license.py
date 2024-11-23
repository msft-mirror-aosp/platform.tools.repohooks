#!/usr/bin/env python3
#
# Copyright (C) 2024 The Android Open Source Project
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

"""Check if the given files in a given commit has an AOSP license."""

import argparse
import os
import re
import sys

_path = os.path.realpath(__file__ + '/../..')
if sys.path[0] != _path:
    sys.path.insert(0, _path)
del _path

# We have to import our local modules after the sys.path tweak.  We can't use
# relative imports because this is an executable program, not a module.
# pylint: disable=import-error,wrong-import-position
import rh.git


# AOSP uses the Apache2 License: https://source.android.com/source/licenses.html
# Spaces and comment identifiers in different languages are allowed at the
# beginning of each line.
AOSP_LICENSE_HEADER = (
    r"""[ #/\*]*Copyright \(C\) 20\d\d The Android Open Source Project
[ #/\*]*\n?[ #/\*]*Licensed under the Apache License, Version 2.0 """
    r"""\(the "License"\);
[ #/\*]*you may not use this file except in compliance with the License\.
[ #/\*]*You may obtain a copy of the License at
[ #/\*]*
[ #/\*]*http://www\.apache\.org/licenses/LICENSE-2\.0
[ #/\*]*
[ #/\*]*Unless required by applicable law or agreed to in writing, software
[ #/\*]*distributed under the License is distributed on an "AS IS" BASIS,
[ #/\*]*WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or """
    r"""implied\.
[ #/\*]*See the License for the specific language governing permissions and
[ #/\*]*limitations under the License\.
"""
)


license_re = re.compile(AOSP_LICENSE_HEADER, re.MULTILINE)


AOSP_LICENSE_SUBSTR = 'Licensed under the Apache License'


def check_license(contents: str) -> bool:
    """Verifies the AOSP license/copyright header."""
    return license_re.search(contents) is not None


def get_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description=(
            'Check if the given files in a given commit has an AOSP license.'
        )
    )
    parser.add_argument(
        'file_paths',
        nargs='+',
        help='The file paths to check.',
    )
    parser.add_argument(
        '--commit_hash',
        '-c',
        help='The commit hash to check.',
        # TODO(b/370907797): Read the contents on the file system by default
        # instead.
        default='HEAD',
    )
    return parser


def main(argv: list[str]):
    """The main entry."""
    parser = get_parser()
    args = parser.parse_args(argv)
    commit_hash = args.commit_hash
    file_paths = args.file_paths

    all_passed = True
    for file_path in file_paths:
        contents = rh.git.get_file_content(commit_hash, file_path)
        if not check_license(contents):
            has_pattern = contents.find(AOSP_LICENSE_SUBSTR) != -1
            if has_pattern:
                print(f'Malformed AOSP license in {file_path}')
            else:
                print(f'Missing AOSP license in {file_path}')
            all_passed = False
    if not all_passed:
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
