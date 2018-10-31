Ansible Playbooks for Automated Deployment of core servers for HASTE



Tested with Ubuntu 18.04 LTS

Ensure that SSH configuration and IP addresses are configured (in `~/.ssh/config` and `/etc/hosts`) first. See 'hostnames.yml' for more details.
**Note that many hosts do not have public IPs, you will need to configure SSH forwarding via one of the servers with a public IP**

NOTE for the Metadata Server: MongoDB authentication needs to be turned *off* to add the users, then 
needs to be turned back on again. See mongodb.conf.j2

Instructions for deploying the auto-configuration service are found in that repo.

For HPC2N use -i hosts_hpc2n

```
ansible -i hosts_hpc2n all -a "echo hi"
```

To deploy entire pipeline (dry run):

```
ansible-playbook -i hosts_hpc2n site.yml --check
```

To deploy for real:
```
ansible-playbook -i hosts_hpc2n site.yml
```



Contributors: Ben Blamey
