#!/bin/bash                                                                                     

# Determine the date and create necessary directories.
Backup_Initiated=$(date +%s)
Date_Main_Directory=$(date +\%F)
Date_Subdirectory=Backup_$(date +\%F-\%H:\%I:\%S)
mkdir -p /SaturnPool/Backups/{Apps,Kubernetes}/$Date_Main_Directory/$Date_Subdirectory


Backup the general apps directory.
cd /SaturnPool/Apps/
for i in *;
    do tar -czvf "/SaturnPool/Backups/Apps/$Date_Main_Directory/$Date_Subdirectory/${i%/}.tar" "$i";
done || echo | mail -s "FAILED TO BACKUP APPS FOLDER - $(date)" && exit 1;


#Backup the Kubernetes apps directory.
cd /SaturnPool/Kubernetes/
for i in *;
    do tar -czvf "/SaturnPool/Backups/Kubernetes/$Date_Main_Directory/$Date_Subdirectory/${i%/}.tar" "$i";
done || echo | mail -s "FAILED TO BACKUP KUBERNETES FOLDER - $(date)" && exit 1;


#Collect metrics for the verification email.
New_Backup_Size="$(du -ch /SaturnPool/Backups/{Apps,Kubernetes}/$Date_Main_Directory/$Date_Subdirectory | grep total | awk '{print $1}')"
Total_Backup_Size="$(du -ch /SaturnPool/Backups/{Apps,Kubernetes} | grep total | awk '{print $1}')"
Remaining_Disk_Space="$(df -h | grep '/SaturnPool' | awk '{print $4}')"
Created_Dirs="$(cd /SaturnPool/Backups && tree -h {Apps,Kubernetes}/$Date_Main_Directory/)"

#Construct and send the verification email.
echo -e "\
     A new backup has been performed.\n \
----------------------------------------------------------------\n \
Backup Duration:\t\t $(expr $(date +%s) - $Backup_Initiated) Seconds\n \
New Backup Size:\t\t$New_Backup_Size\n \
Total Backup Size:\t\t $Total_Backup_Size\n \
Remaining Disk Space:\t    $Remaining_Disk_Space\n \
----------------------------------------------------------------\n\n \
\t\tNew Backup Structure:
----------------------------------------------------------------\n \
$Created_Dirs\n \
----------------------------------------------------------------" \
| mail -s "Apps Backed Up - $(date +"%m-%d-%y") ($Remaining_Disk_Space free)" thomaszimmerman93@gmail.com
