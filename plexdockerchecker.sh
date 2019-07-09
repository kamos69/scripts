#!/bin/bash
#name=Plex Media Server check and restart
#description=This script will restart PLEX if it does not respond after two attempts.
#arrayStarted=true


dockerid=$(docker ps -aqf "name=plex")
if [ "$dockerid" == "" ]; then
	echo "ERR $(date) - Could not get a docker id for docker name \"Plex\"."
	exit 1;
fi

# Do not check between 1:55am to 2:30am
currentTime=`date +"%H%M%S"`
if [[ ! ( "$currentTime" < "015500" || "$currentTime" > "023000" ) ]]; then
	exit 0;
fi

firstcheck=$((curl -sSf -m30 http://127.0.0.1:32400/web/) 2>&1)
if [ "$firstcheck" != "" ]; then
	echo "WRN $(date) - Plex did not respond in first check, waiting 15 seconds.."
	source /home/kamos/scripts/pushbullet.sh "WRN $(date) - Plex did not respond in first check, waiting 15 seconds.."
	sleep 15
	secondcheck=$((curl -sSf -m30 http://127.0.0.1:32400/web/) 2>&1)
	if [ "$secondcheck" != "" ]; then
		echo "WRN $(date) - Plex did not respond in second check either, restarting docker container."
		source /home/kamos/scripts/pushbullet.sh "WRN $(date) - Plex did not respond in second check either, restarting docker container."

		echo "INF $(date) - Stopping docker $dockerid."
		source /home/kamos/scripts/pushbullet.sh "INF $(date) - Stopping docker $dockerid."
		docker stop $dockerid

		echo "INF $(date) - Waiting 15 seconds.."
		source /home/kamos/scripts/pushbullet.sh "INF $(date) - Waiting 15 seconds.."
		sleep 15

		echo "INF $(date) - Starting docker $dockerid."
		source /home/kamos/scripts/pushbullet.sh "INF $(date) - Starting docker $dockerid."
		docker start $dockerid
	else
		echo "INF $(date) - Plex docker container responded on second attempt."
		source /home/kamos/scripts/pushbullet.sh "INF $(date) - Plex docker container responded on second attempt."
	fi
else
	echo "INF $(date) - Plex docker container responded on first attempt."
#	source /home/kamos/scripts/pushbullet.sh "INF $(date) - Plex docker container responded on first attempt."
fi
