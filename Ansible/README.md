## Todo 
Create an ansible [inventory](https://docs.ansible.com/ansible/latest/plugins/inventory/yaml.html) containing a or a list of IP addresses to run the playbook against.

Example inventory
```yaml
all:
 hosts: "192.168.1.1"
mongodb:
 hosts: "192.168.1.2"
```

## How to run

- [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- The command to run the playbook takes both an inventroy and playbook as arguments. 
  example. `ansible-playbook MongoDB-4.2.yml -i inventory.yaml`

## Some details on files
#### [MongoDB-4.2](/Ansible/MongoDB-4.2.yml)
Tested on Debian 9
    - Installs MongoDB 4.2