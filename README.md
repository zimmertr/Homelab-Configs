# Homelab Configs

## Summary
Collection of configuration files, scripts, cookbooks, etc used to reprovision my homelab from scratch. As of writing this README, this repo is a work in progress and is just a dropping place for files. 

## The files:

1) `docker-compose.yml`: Docker Compose file used to provision most of the services used in my lab.  

2) `snmpd.conf`: SNMP Configuration file

3) `nextcloud_tweaks.txt`: It is necessary to configure Nextcloud after deploying the container to add trusted hosts and modify the overwrite host due to it being located behind a proxy.  

4) `crontab`: List of cron tasks configured on Proxmox. Including those to perform directory backups, cleanups, zpool scrubs, smart tests, etc.

5) `status.cfg`: Config used by Proxmox for configuring the external metrics server. Configured for InfluxDB on external server. 

6) `iptables.txt`: Tweaks for iptables necessary when running docker on proxmox/kvm: https://anteru.net/blog/2017/docker-kvm-and-iptables/index.html

7) `Postfix`: https://github.com/ShoGinn/homelab/wiki/Proxmox-PostFix---Email#proxmox

8) `find_status.sh`: Shell script used to collect basic metrics about containers running on current host.
