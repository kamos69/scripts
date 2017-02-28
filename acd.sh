#!/bin/bash
/usr/bin/rclone mount acd:Encrypted /home/kamos/acd/.cloud --read-only --allow-other &
sudo ENCFS6_CONFIG='/home/kamos/acd/encfs6.xml' encfs --extpass='echo ' --public /home/kamos/acd/.cloud /home/kamos/acd/cloud
#unionfs-fuse -o cow -o allow_other /home/kamos/acd/local=RW:/home/kamos/acd/cloud=RO /home/kamos/cloud
/usr/bin/rclone mount acdcrypt: /home/kamos/media --read-only --allow-other &
unionfs-fuse -o cow -o allow_other /home/kamos/.media=RW:/home/kamos/media=RO /home/kamos/cloud
