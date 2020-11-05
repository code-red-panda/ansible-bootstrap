# About
The `main.yml` playbook can set up many different MySQL environments.

By default, it will not execute any role.

Each role (MySQL environment) has a `--tag` that must be specified to be executed.

Each role is explained in each section below.

# async57
This playbook will:
- Install the latest Percona Server 5.7
- Configure a my.cnf for replication and Orchestrator
- Configure asynchronous replication for 1 source + any number of replicas (it all depends on your hosts file)
- Create a MySQL user and a .my.cnf for your OS user
- Load the Sakila database

Pre-requisites:
- Python 2.7

Steps:

Update the inventory `hosts` file for the `all:vars` and `async57` groups:
- Set the `os_user` to your OS user that should get the .my.cnf (the `os_user` must exist on all hosts!)
- Remove `ansible_connection=local` if Ansible is running remotely
- Only 1 server should be assigned `mysql_role=source`
- Update IPs accordingly, the `source_ip` should be the IP of the `mysql_role=source` server 
- Add/remove replicas
```
[all:vars]
os_user=vagrant

[async57]
mysql1 ansible_host=192.168.2.91 mysql_role=source ansible_connection=local
mysql2 ansible_host=192.168.2.92 mysql_role=replica
mysql2 ansible_host=192.168.2.93 mysql_role=replica

[async57:vars]
source_ip=192.168.2.91
```
Run the playbook:
```
ansible-playbook main.yml --tags=async57
```
