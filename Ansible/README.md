# Prerequisites
These Ansible scripts in the given context will require the following to ensure you have utilization.

- [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

- Create an [inventory](https://docs.ansible.com/ansible/latest/plugins/inventory/yaml.html) containing a or a list of IP addresses appropriate for your network.

Example inventory
```yaml
all:
 hosts: "192.168.1.1"
mongodb:
 hosts: "192.168.1.2"
```


# Playbook Details 
The command to run the playbook takes both an inventroy and playbook as arguments.  example. `ansible-playbook MongoDB-4.2.yml -i inventory.yaml`

| Title | File Location | Summary | Test Environment |
| ------ | ------ | ------ | ------ |
| **MongoDB-4.2** | [/Ansible/MongoDB-4.2.yml](/Ansible/MongoDB-4.2.yml) | Installs MongoDB Server and automates user creation | Debian 9 |


