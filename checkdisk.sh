#!/bin/bash
# This script checks disk usage against a threashold. If the usage exceeds the threshold, it deletes files older than max_age.
# Update the Settings folders accordingly and set yoru max_usage and file_age.
# Make the file executable by running chmod a+x checkdisk.sh

if pidof -o %PPID -x "$0"; then
   echo "$(date "+%d.%m.%Y %T") Exit, already running."
   exit 1
fi

#Settings
root='/dev/md2'
media_folder='/mnt/downloads/'
max_usage=95%
file_age=15
LOGFILE="/home/kamos/logs/checkdisk.log"

current_usage=$( df -h | grep $root | awk {'print $5'} )
echo "$(date "+%d.%m.%Y %T") Usage for $root is $current_usage." | tee -a "$LOGFILE"
if [ ${current_usage%?} -ge ${max_usage%?} ]; then
    echo "$(date "+%d.%m.%Y %T") Current disk space is above threshold. Deleting files older than $file_age days." | tee -a "$LOGFILE"
    find $media_folder -type f -mtime +$file_age -delete
    current_usage=$( df -h | grep $root | awk {'print $5'} )
    echo "$(date "+%d.%m.%Y %T") Disk check done. Current disk use is $current_usage." | tee -a "$LOGFILE"
    echo "$(date "+%d.%m.%Y %T") Cleaning up..." | tee -a "$LOGFILE"
    find -type d -empty -delete

elif [ ${current_usage%?} -lt ${max_usage%?} ]; then
    echo "$(date "+%d.%m.%Y %T") Current disk space is below threshold." | tee -a "$LOGFILE"
fi

exit
