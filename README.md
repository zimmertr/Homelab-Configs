# Homelab Configs

## Summary
Collection of configuration files, scripts, cookbooks, etc used to reprovision my homelab from scratch. As of writing this README, this repo is a work in progress and is just a dropping place for files. 

## The files:

**Current**
1) `backup_apps.sh`: Shell script targeted by cron to automatically backup important application directories for K8s and email a formatted report daily with metrics about the backup procedure.

2) `crontab`: Miscellaneous cron tasks to back up K8s apps, Scrub my ZFS pool, and perform ZFS Snapshots. 

3) `iptables.txt`: Tweaks for iptables necessary when running docker on proxmox/kvm.
    - https://anteru.net/blog/2017/docker-kvm-and-iptables/index.html

6) `Postfix`: How to configure a Gmail relay for Proxmox emails.
    - https://github.com/ShoGinn/homelab/wiki/Proxmox-PostFix---Email#proxmox

5) `snmpd.conf`: SNMP Configuration file.

**Legacy**

1) `crontab`: LEGACY version of crontab. Perform directory backups, cleanups, zpool scrubs, smart tests, etc.

2) `docker-compose.yml`: Legacy Docker Compose file that I used to use to provision most of the services used in my lab.  

3) `find_status.sh`: Shell script used to collect basic metrics about containers running on current host.

4) `nextcloud_tweaks.txt`: It is necessary to configure Nextcloud after deploying the container to add trusted hosts and modify the overwrite host due to it being located behind a proxy.  

5) `status.cfg`: Config used by Proxmox for configuring the external metrics server. Configured for InfluxDB on external server. 
