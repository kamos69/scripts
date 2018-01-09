#!/bin/sh
echo "Starting Backup on $(date)"

# Set backup path
BK_PATH=/home/$USER/backups

### Sickrage
# File location
SR_PATH=/home/$USER/.sickrage
# Create dir if it doesn't exist
mkdir -p "$BK_PATH/sickrage"
# Create archive
/bin/tar -cvf $BK_PATH/sickrage/sickrage-`date \+%Y\%m\%d`.tar.gz "$SR_PATH/config.ini" "$SR_PATH/cache.db" "$SR_PATH/sickbeard.db" "$SR_PATH/cache" "$SR_PATH/failed.db"

### CouchPotato
# File location
CP_PATH=/home/$USER/.couchpotato
# Create dir if it doesn't exist
mkdir -p "$BK_PATH/couchpotato"
# Create archive
/bin/tar -cvf $BK_PATH/couchpotato/couchpotato-`date \+%Y\%m\%d`.tar.gz "$CP_PATH/settings.conf" "$CP_PATH/database"

### Rtorrent
# File location
RT_PATH=/home/$USER
# Create dir if it doesn't exist
mkdir -p "$BK_PATH/rtorrent"
# Create archive
/bin/tar -cvf $BK_PATH/rtorrent/rtorrent-`date \+%Y\%m\%d`.tar.gz "$RT_PATH/.sessions/" "$RT_PATH/.rtorrent.rc"

### Deluge
# File location
DE_PATH=/home/$USER/.config/deluge
# Create dir if it doesn't exist
mkdir -p "$BK_PATH/deluge"
# Create archive
/bin/tar -cvf $BK_PATH/deluge/deluge-`date \+%Y\%m\%d`.tar.gz "$DE_PATH/core.conf" "$DE_PATH/web.conf" "$DE_PATH/session.state" "$DE_PATH/state/"

### PlexPy
# File location
PP_PATH=/opt/plexpy
# Create dir if it doesn't exist
mkdir -p "$BK_PATH/plexpy"
# Create archive
sudo /bin/tar -cvf $BK_PATH/plexpy/plexpy-`date \+%Y\%m\%d`.tar.gz "$PP_PATH/config.ini" "$PP_PATH/plexpy.db"

### Ombi
# File location
OMBI_PATH=/opt/plexrequests
# Create dir if it doesn't exist
mkdir -p "$BK_PATH/ombi"
# Create archive
sudo /bin/tar -cvf $BK_PATH/ombi/ombi-`date \+%Y\%m\%d`.tar.gz "$OMBI_PATH/Ombi.sqlite"

### Crontabs
crontab -l > $BK_PATH/cron-backup.txt

### Scripts
# File location
SCRIPTS_PATH=/home/$USER/scripts
# Create dir if it doesn't exist
mkdir -p "$BK_PATH/plexpy"
# Create archive
/bin/tar -cvf $BK_PATH/scripts/scripts-`date \+%Y\%m\%d`.tar.gz $SCRIPTS_PATH

### Plex
# File location
# PLEX_PATH=/var/lib/plexmediaserver/
# Rsync to backup folder
# sudo rsync -azv $PLEX_PATH $BK_PATH/plex/

### Jackett
# File location
JA_PATH=/home/$USER/.config/Jackett
mkdir -p "$BK_PATH/jackett"
# Create archive
/bin/tar -cvf $BK_PATH/jackett/jackett-`date \+%Y\%m\%d`.tar.gz "$JA_PATH/ServerConfig.json"

### Jackett
# File location
JA_PATH=/home/$USER/.config/Jackett
# Create archive
/bin/tar -cvf $BK_PATH/jackett/jackett-`date \+%Y\%m\%d`.tar.gz "$JA_PATH/ServerConfig.json"

### Rclone
# Rsync to backup folder
sudo rsync -azv /home/$USER/.rclone.conf $BK_PATH/

### Config
# File location
CONFIG_PATH=/home/$USER/.config/
mkdir -p "$BK_PATH/config"
# Create archive
sudo /bin/tar -cvf $BK_PATH/config/config-`date \+%Y\%m\%d`.tar.gz  $CONFIG_PATH

### Sync to Cloud
# File Location
ACD_PATH=backups:
# Rclone sync to ACD
#sudo chmod -R 775 $BK_PATH
/usr/bin/rclone copy --transfers=10 --checkers=10 $BK_PATH/ $ACD_PATH -v

### Clean up old backups
/usr/bin/rclone delete $BK_PATH/ --min-age 1M
