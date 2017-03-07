#!/bin/bash
if pidof -o %PPID -x "rclone-cron.sh"; then
echo "rclone-cron.sh running"
exit 1
fi
if find /home/kamos/.media/* -type f -mmin +30 | read
then
/usr/bin/rclone copy /home/kamos/.media/ acdcrypt: --transfers 20 --checkers 20 --min-age 30 --log-file=/home/kamos/logs/local2acd.log
fi
exit

