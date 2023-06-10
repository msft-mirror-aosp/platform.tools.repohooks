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

"""Common errors thrown when repo preupload checks fail."""

import os
import sys
from typing import List, Optional

_path = os.path.realpath(__file__ + '/../..')
if sys.path[0] != _path:
    sys.path.insert(0, _path)
del _path


class HookResult(object):
    """A single hook result."""

    def __init__(self, hook, project, commit, error, files=(),
                 fixup_cmd: Optional[List[str]] = None):
        """Initialize.

        Args:
          hook: The name of the hook.
          project: The name of the project.
          commit: The git commit sha.
          error: A string representation of the hook's result.  Empty on
              success.
          files: The list of files that were involved in the hook execution.
          fixup_cmd: A command that can automatically fix errors found in the
              hook's execution.  Can be None if the hook does not support
              automatic fixups.
        """
        self.hook = hook
        self.project = project
        self.commit = commit
        self.error = error
        self.files = files
        self.fixup_cmd = fixup_cmd

    def __bool__(self):
        return bool(self.error)

    def is_warning(self):
        return False


class HookCommandResult(HookResult):
    """A single hook result based on a CompletedProcess."""

    def __init__(self, hook, project, commit, result, files=(),
                 fixup_cmd=None):
        HookResult.__init__(self, hook, project, commit,
                            result.stderr if result.stderr else result.stdout,
                            files=files, fixup_cmd=fixup_cmd)
        self.result = result

    def __bool__(self):
        return self.result.returncode not in (None, 0)

    def is_warning(self):
        return self.result.returncode == 77
