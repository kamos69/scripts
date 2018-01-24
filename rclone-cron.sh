#!/bin/bash
if pidof -o %PPID -x "rclone-cron.sh"; then
echo "rclone-cron.sh running"
exit 1
fi
if find /home/kamos/.media/* -type f -mmin +15 | read
then
start=$(date +'%s')
echo "$(date "+%d.%m.%Y %T") RCLONE UPLOAD STARTED"
# MOVE FILES OLDER THAN 15 MINUTES
/usr/bin/rclone copy /home/kamos/.media/ boxee: --transfers 20 --checkers 20 --min-age 15 --bwlimit 8M --exclude "/.unionfs-fuse/**" --log-file=/home/kamos/logs/local2gdrive.log -v
echo "$(date "+%d.%m.%Y %T") RCLONE UPLOAD FINISHED IN $(($(date +'%s') - $start)) SECONDS"
fi
exit

