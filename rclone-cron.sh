#!/bin/bash
if pidof -o %PPID -x "rclone-cron.sh"; then
echo "rclone-cron.sh running"
exit 1
fi
if find /home/kamos/.media/* -type f -mmin +15 | read
then
/usr/bin/rclone copy /home/kamos/.media/ boxee: --transfers 20 --checkers 20 --min-age 15 --stats 10s --bwlimit 8M --exclude "/.unionfs-fuse/**" --log-file=/home/kamos/logs/local2gdrive.log -vv
fi
exit

