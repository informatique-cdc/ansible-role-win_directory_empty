#!/usr/bin/python
# -*- coding: utf-8 -*-

# This is a windows documentation stub.  Actual code lives in the .ps1
# file of the same name.

# Copyright 2020 Informatique CDC. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License

from __future__ import absolute_import, division, print_function
__metaclass__ = type


ANSIBLE_METADATA = {'metadata_version': '1.1',
                    'status': ['preview'],
                    'supported_by': 'community'}

DOCUMENTATION = r'''
---
module: win_directory_empty
short_description: Ensure that a folder is empty
author:
    - Stéphane Bilqué (@sbilque) Informatique CDC
description:
    - This Ansible module ensures that a or more folders are empty.
options:
    path:
        description:
            - A path to one or more locations of the items being removed.
        type: str
        required: yes
    exclude:
        description:
            - An item or items that this module excludes in the operation.
        type: str
        required: no

'''

EXAMPLES = r'''
---
- name: test the win_directory_empty module
  hosts: all
  gather_facts: false

  roles:
    - win_directory_empty

  tasks:

    - name: Ensure the temp folder is empty
      win_directory_empty:
        path: 'c:\windows\temp'

    - name: Ensure the temp folder is empty
      win_directory_empty:
        path:
          - 'c:\windows\temp'
          - 'c:\temp'
        exclude: '*1*'

    - name: Ensure the temp folder is empty
      win_directory_empty:
        path:
          - 'c:\windows\temp'
          - 'c:\temp'
        exclude:
          - 'vmware-*.log'
          - '*2*'
'''

RETURN = r'''
'''
