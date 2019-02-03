#!/bin/bash                                                                                     

# Set the main date variable.
Date_Main_Directory=$(date +\%F)


# Create directory structsure for date/time and backup the general apps directory.
cd /SaturnPool/Apps/
Date_Apps_Subdirectory=Backup_$(date +\%F-\%H:\%I:\%S)
Apps_Backup_Initiated=$(date +%s)
mkdir -p /SaturnPool/Backups/Apps/$Date_Main_Directory/$Date_Apps_Subdirectory

for i in *;
    do tar -czvf "/SaturnPool/Backups/Apps/$Date_Main_Directory/$Date_Apps_Subdirectory/${i%/}.tar" "$i";
done || exit 1;


# Create directory structsure for date/time and backup the K8s apps directory.
cd /SaturnPool/Kubernetes/
Date_K8s_Subdirectory=Backup_$(date +\%F-\%H:\%I:\%S)
K8s_Backup_Initiated=$(date +%s)
mkdir -p /SaturnPool/Backups/Kubernetes/$Date_Main_Directory/$Date_K8s_Subdirectory

for i in *;
    do tar -czvf "/SaturnPool/Backups/Kubernetes/$Date_Main_Directory/$Date_K8s_Subdirectory/${i%/}.tar" "$i";
done ||  exit 1;


# Collect backup metrics for the verification email.
New_Backup_Size="$(du -ch /SaturnPool/Backups/{Apps,Kubernetes}/$Date_Main_Directory/{$Date_Apps_Subdirectory,$Date_K8s_Subdirectory} | grep total | awk '{print $1}')"
Total_Backup_Size="$(du -ch /SaturnPool/Backups/{Apps,Kubernetes} | grep total | awk '{print $1}')"
Remaining_Disk_Space="$(df -h | grep '/SaturnPool' | awk '{print $4}')"
Created_Dirs="$(cd /SaturnPool/Backups && tree -h {Apps,Kubernetes}/$Date_Main_Directory/)"


# Construct and send the verification email.
echo -e "\
     A new backup has been performed.\n \
----------------------------------------------------------------\n \
Apps Backup Duration:\t    $(expr $(date +%s) - $Apps_Backup_Initiated) Seconds\n \
K8s Backup Duration:\t    $(expr $(date +%s) - $K8s_Backup_Initiated) Seconds\n \
New Backup Size:\t\t$New_Backup_Size\n \
Complete Backup Size:\t   $Total_Backup_Size\n \
Remaining Disk Space:\t    $Remaining_Disk_Space\n \
----------------------------------------------------------------\n\n \
\t\tNew Backup Structure:
----------------------------------------------------------------\n \
$Created_Dirs\n \
----------------------------------------------------------------" \
| mail -s "Apps Backed Up - $(date +"%m-%d-%y") ($Remaining_Disk_Space free)" thomaszimmerman93@gmail.com

