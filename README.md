# win_directory_empty - Ensure that a folder is empty

## Synopsis

* This Ansible module ensures that a or more folders are empty.

## Parameters

| Parameter     | Choices/<font color="blue">Defaults</font> | Comments |
| ------------- | ---------|--------- |
|__path__<br><font color="purple">str</font></font> / <font color="red">required</font> |  | A path to one or more locations of the items being removed. |
|__exclude__<br><font color="purple">str</font></font> |  | An item or items that this module excludes in the operation. |

## Examples

```yaml
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

```

## Authors

* Stéphane Bilqué (@sbilque) Informatique CDC

## License

This project is licensed under the Apache 2.0 License.

See [LICENSE](LICENSE) to see the full text.
