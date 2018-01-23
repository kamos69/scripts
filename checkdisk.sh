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
media_folder='/home/kamos/.media/'
max_usage=95%
file_age=30

current_usage=$( df -h | grep $root | awk {'print $5'} )
if [ ${current_usage%?} -ge ${max_usage%?} ]; then
    echo "$(date "+%d.%m.%Y %T") Current disk space is above threshold. Deleting files older than $max_age days."
    find $media_folder -type f -mtime +$file_age -print

elif [ ${current_usage%?} -lt ${max_usage%?} ]; then
    echo "$(date "+%d.%m.%Y %T") Current disk space is below threshold. "
fi

exit
