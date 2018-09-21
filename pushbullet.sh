#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Usage: $0 <message> [title]"
	exit
fi

MESSAGE=$1
TITLE=$2

if [ $# -lt 2 ]; then
	TITLE="`whoami`@${HOSTNAME}"
fi

ACCESS_TOKEN="o.8ADpCA1QSx4MwW7YvNAI6f6KusXeRrCN"

curl -s -u $ACCESS_TOKEN: -X POST https://api.pushbullet.com/v2/pushes --header 'Content-Type: application/json' --data-binary '{"type": "note", "title": "'"$TITLE"'", "body": "'"$MESSAGE"'"}' >/dev/null 2>&1 
