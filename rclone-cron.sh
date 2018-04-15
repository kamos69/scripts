#!/bin/bash

if pidof -o %PPID -x "rclone-cron.sh"; then
   echo "rclone-cron.sh running"
   exit 1
fi

LOGFILE="/home/kamos/logs/local2gdrive.log"
FROM="/home/kamos/.media/"
TO="boxee:"

start=$(date +'%s')
echo "$(date "+%d.%m.%Y %T") RCLONE UPLOAD STARTED" | tee -a $LOGFILE

# MOVE FILES OLDER THAN 15 MINUTES
/usr/bin/rclone copy "$FROM" "$TO" --transfers=20 --checkers=20 --exclude "/.unionfs-fuse/**" --min-age 15m --bwlimit 8M --log-file=$LOGFILE --log-level INFO
echo "$(date "+%d.%m.%Y %T") RCLONE UPLOAD FINISHED IN $(($(date +'%s') - $start)) SECONDS" | tee -a $LOGFILE
fi
exit
