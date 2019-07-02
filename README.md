# Scripts for use on Media Server
Scripts for managing my Ubuntu / Rclone / Plex Server.

### Prerequisites
NOTE: It is assumed that you used the Quickbox script to setup your server using the default folder structures.

### Getting Started
Clone the repository locally:
```
cd ~
git clone https://github.com/kamos69/scripts.git scripts/
cd ~/scripts/
chmod +x *.sh
```

### Crontabs
Once yourCrontab for `backup.sh`
```
@reboot /home/$USER/unionfs-fuse.sh > /home/$USER/logs/acd_boot.log 2>&1
* * * * * /home/$USER/scripts/rclone-cron.sh > /dev/null 2>&1
*/5 * * * * python /home/$USER/scripts/acdrclonemountchecker.py > /dev/null 2>&1
30 3 * * 1 /home/$USER/scripts/backups.sh >> /home/$USER/logs/backups.log 2>&1
0 * * * * sudo /home/$USER/scripts/plexscan.sh  > /dev/null 2>&1
```
