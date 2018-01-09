#!/bin/bash
# Unmount
fusermount -uz /home/kamos/media

# Mount
/usr/bin/rclone mount \
--read-only \
--allow-other \
--acd-templink-threshold 0 \
--stats 10s \
--buffer-size 1G \
-vv \
--log-file=/home/kamos/logs/mount.log \
demedia: /home/kamos/media &
