# mysql-ansible
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
# async
Clone this repository to the master host async1 (by default, the inventory assumes Ansible will run on async1).
Update the hosts file with your IPs.
If not using vagrant, change the os_user variable in the async.yml playbook.
Copy these files into the Ansible directory and run the playbook:
cat hosts >> /etc/ansible/hosts ; cp async.yml /etc/ansible

ansible-playbook /etc/ansible/async.yml
