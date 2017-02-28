#!/bin/bash
if mountpoint -q "/home/kamos/acd/.cloud"; then
	echo "Encrypted remote directory already mounted."
	exit 2
else
	echo "Mounting encrypted remote directory."
	fusermount -uz /home/kamos/acd/.cloud
	/usr/bin/rclone mount acd:Encrypted /home/kamos/acd/.cloud --read-only --allow-other &
	sleep 5
	if mountpoint -q "/home/kamos/acd/.cloud"; then
		echo "Remote encrypted directory mounted successfully."
	else
		echo "Error mounting encrypted remote directory."
		exit 1
	fi
fi

exit 0
