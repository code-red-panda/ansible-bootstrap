# mysql-ansible

# async-57
This playbook will:
- Install the latest Percona Server 5.7
- Configure a my.cnf for replication
- Configure asynchronous replication (1 source + any number of replicas)
- Create a MySQL user and .my.cnf for an OS user
- Load the Sakila database

Pre-requisites:
- Python 2

Steps:
1. As root, prepare the Ansible working directory and copy these files:
```
cd ./mysql-ansible
mkdir -p /etc/ansible/roles/ && cp -r ./roles/async-57 /etc/ansible/roles/ && cp async-57-hosts async-57.yml /etc/ansible/
```
2. Update the `async-57` inventory:
- Remove `ansible_connection=local` if Ansible is running remotely
- Update IPs accordingly
- Add/remove replicas
```
[async-57-source]
async-57-1 ansible_connection=local ansible_host=192.168.2.X

[async-57-replicas]
async-57-2 ansible_host=192.168.2.X
async-57-3 ansible_host=192.168.2.X
```
3. Update the `async-57` variables.
- The `os_user` must exist on all servers
- The `source_ip` must be the IP of `async-57-1` that the MySQL replicas will can connect to on:
```
os_user=vagrant
source_ip=192.168.2.X
mysql_user: dba
mysql_password: Dba1234!
repl_user: repl
repl_password: Repl1234!
```
4. Run the playbook:
```
ansible-playbook -i /etc/ansible/async-57-hosts /etc/ansible/async-57.yml
```
