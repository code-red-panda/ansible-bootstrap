# About
Currently, these playbooks will only work on RHEL/CentOS 7.

The `main.yml` playbook can set up many different MySQL environments.

By default, it will not execute any role.

Each role (MySQL environment) has a `--tag` that must be specified to be executed.

Each role is explained in each section below.

# async57
This playbook will:
- Install the latest Percona Server 5.7
- Configure /etc/my.cnf for replication and Orchestrator
- Configure asynchronous replication for 1 source + any number of replicas (it all depends on your hosts file)
- Create a MySQL user for you (along with a ~/.my.cnf), a replication user, and an Orchestrator user
- Load the Sakila database

Pre-requisites:
- Python 2.7

Steps:

Update the inventory `hosts` file for the `async57` group:
- Remove `ansible_connection=local` if Ansible is running remotely
- Only 1 server should be assigned `mysql_role=source` and it must be named `mysql1`
- Any number of servers can be assigned `mysql_role=replica`. So add/remove replicas as needed.
```
[async57]
mysql1 ansible_host=192.168.2.91 mysql_role=source ansible_connection=local
mysql2 ansible_host=192.168.2.92 mysql_role=replica
mysql3 ansible_host=192.168.2.93 mysql_role=replica
```
Update `group_vars/all/main.yml`:
- It contains variables for other roles so all of them do not apply right now
- At the minimum, set the `os_user` to your OS user that should get the .my.cnf (the `os_user` must exist on all hosts!)

Run the playbook:
```
ansible-playbook main.yml --tags=async57
```

# orchestrator

This playbook will:
- Install Orchestrator and Orchestrator Client and configure it
- Create an Orchestrator systemd service
- Discover one cluster

Pre-requisites:
- A MySQL async cluster

Steps:

Update the inventory `hosts` file for the `orchestrator` group:
- Remove `ansible_connection=local` if Ansible is running remotely
- Provide the `monitor` server IP. This is where you want to run Orchestrator
```
[orchestrator]
monitor ansible_host=192.168.2.91 ansible_connection=local
```
Update `group_vars/all/main.yml`:
- It contains variables for other roles so all of them do not apply right now
- At a minimum, set the `orc_cluster` to discover. The name MUST be a group in inventory. The default is `async57`.

Update `roles/orchestrator/vars/main.yml` to further change Orchestrator configuration options as needed, but the defaults will work.

Run the playbook:
```
ansible-playbook main.yml --tags=orchestrator
```
