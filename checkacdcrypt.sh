#!/bin/bash
if mountpoint -q "/home/kamos/media"; then
	echo "Encrypted remote directory already mounted."
	exit 2
else
	echo "Mounting encrypted remote directory."
	fusermount -uz /home/kamos/media
	/usr/bin/rclone mount acdcrypt: /home/kamos/media --read-only --allow-other &
	sleep 5
	if mountpoint -q "/home/kamos/media"; then
		echo "Remote encrypted directory mounted successfully."
	else
		echo "Error mounting encrypted remote directory."
		exit 1
	fi
fi

exit 0
