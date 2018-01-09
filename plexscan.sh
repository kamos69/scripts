#!/bin/bash
## PLEX SCAN ONLY NEW/MODIFED FOLDERS SINCE LAST RUN
## OS: Linux Ubuntu 16.04
## Make script executable by chmod a+x plexscan.sh
## Add script to crontab -e ( paste the line bellow without ## )
## */30 * * * *   /path to script/plex-scan-new.sh >/dev/null 2>&1
## Make sure you disable all Plex automatic & scheduled library scans.
## Credit to https://github.com/ajkis for the original script.

if pidof -o %PPID -x "$0"; then
   echo "$(date "+%d.%m.%Y %T") Exit, already running."
   exit 1
fi

#SETTINGS
MOVIELIBRARY="/home/kamos/media/movies"
MOVIESECTION=2
TVLIBRARY="/home/kamos/media/tv"
TVSECTION=1
LOGFILE="/home/kamos/logs/plexscan.log"
FOLDERLISTFILE="/home/kamos/.cache/folderlistfile"
LASTRUNFILE="/home/kamos/.cache/lastrunfile"


export LD_LIBRARY_PATH=/usr/lib/plexmediaserver
export PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR=/var/lib/plexmediaserver/Library/Application\ Support

if [[ ! -f "$LASTRUNFILE" ]]; then
    touch $LASTRUNFILE
fi
echo "$(date "+%d.%m.%Y %T") PLEX SCAN FOR NEW/MODIFIED FILES AFTER: $(date -r $LASTRUNFILE)" | tee -a "$LOGFILE"

if [[ -f "$FOLDERLISTFILE" ]]; then
    echo "Removing previous folder list" | tee -a "$LOGFILE"
    rm $FOLDERLISTFILE
fi

start=$(date +'%s')
startmovies=$(date +'%s')
echo "Scaning for new files: $MOVIELIBRARY" | tee -a "$LOGFILE"
find "$MOVIELIBRARY" -mindepth 1 -type d -cnewer $LASTRUNFILE |
while read mfile; do
        echo "$(date "+%d.%m.%Y %T") New file detected: $mfile" | tee -a "$LOGFILE"
#        MFOLDER=$(dirname "${mfile}")
#        echo "$MFOLDER" | tee -a "$FOLDERLISTFILE"
        $LD_LIBRARY_PATH/Plex\ Media\ Scanner -s -r -c "$MOVIESECTION" -d "$mfile"
done
echo "$(date "+%d.%m.%Y %T") Movie files scanned in $(($(date +'%s') - $startmovies)) seconds" | tee -a "$LOGFILE"

startseries=$(date +'%s')
echo "Scaning for new files: $TVLIBRARY" | tee -a "$LOGFILE"
find "$TVLIBRARY" -mindepth 2 -type f -cnewer $LASTRUNFILE |
while read tvfile; do
        echo "$(date "+%d.%m.%Y %T") New file detected: $tvfile" | tee -a "$LOGFILE"
        TVFOLDER=$(dirname "${tvfile}")
        echo "$TVFOLDER" | tee -a "$FOLDERLISTFILE"
        $LD_LIBRARY_PATH/Plex\ Media\ Scanner -s -r -c "$TVSECTION" -d "$TVFOLDER"
done
echo "$(date "+%d.%m.%Y %T") TV folders scanned in $(($(date +'%s') - $startseries)) seconds" | tee -a "$LOGFILE"

echo "$(date "+%d.%m.%Y %T") Move & TV folders scanned in $(($(date +'%s') - $start)) seconds" | tee -a "$LOGFILE"
echo "$(date "+%d.%m.%Y %T") Setting lastrun for next folder scans" | tee -a "$LOGFILE"
touch $LASTRUNFILE
echo "------------------------------------------------------------------------------------------------------------" | tee -a "$LOGFILE"

exit
