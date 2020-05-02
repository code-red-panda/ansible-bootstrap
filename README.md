# ansible-bootstrap
1. Set an `os_user` variable. Ex: If all hosts have a `vagrant` user then add the following to the inventory file:
```
[all:vars]
os_user=vagrant
```
2. Copy the files into the Ansible directory and run the playbook:
```
mkdir /etc/ansible/files/ ; cp files/* /etc/ansible/files/ ; cp bootstrap.yml /etc/ansible/

ansible-playbook /etc/ansible/bootstrap.yml
```
