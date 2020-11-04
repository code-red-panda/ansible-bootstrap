# mysql-ansible

# async-57
This playbook will:
- Install the latest Percona Server 5.7
- Configure a my.cnf for replication and Orchestrator
- Configure asynchronous replication (1 source + any number of replicas)
- Create a MySQL user and .my.cnf for an OS user
- Load the Sakila database

Pre-requisites:
- Python 2.7

Steps:
1. Update the inventory `hosts` file for `async57` group:
- Remove `ansible_connection=local` if Ansible is running remotely
- Update IPs accordingly
- Add/remove replicas
```
[async57]
async57-1 ansible_connection=local ansible_host=192.168.2.X mysql_role=source
async57-2 ansible_host=192.168.2.X mysql_role=replica
async57-3 ansible_host=192.168.2.X mysql_role=replica
```
2. Update the variables.
- The `os_user` must exist on all servers (group_vers to do)
```
os_user=vagrant
source_ip=192.168.2.X
mysql_user: dba
mysql_password: Dba1234!
repl_user: repl
repl_password: Repl1234!
```
3. Run the playbook:
```
ansible-playbook main.yml --extra-vars "run_play=async57"
```
