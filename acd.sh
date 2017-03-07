#!/bin/bash
# Mount ACD ENCFS
/usr/bin/rclone mount acd:Encrypted /home/kamos/acd/.cloud --read-only --allow-other &

# Setup ENCFS
sudo ENCFS6_CONFIG='/home/kamos/acd/encfs6.xml' encfs --extpass='echo ' --public /home/kamos/acd/.cloud /home/kamos/acd/cloud

# Mount ACD Crypt
#/usr/bin/rclone mount acdcrypt: /home/kamos/media --read-only --allow-other &
/usr/bin/rclone mount \
       --read-only \
       --allow-other \
       --buffer-size 1G \
       --acd-templink-threshold 0 \
       acdcrypt: /home/kamos/media &

# Setup Unionfs-Fuse
unionfs-fuse -o cow -o allow_other /home/kamos/.media=RW:/home/kamos/media=RO /home/kamos/cloud
