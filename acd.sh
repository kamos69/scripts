#!/bin/bash
# Mount ACD ENCFS
#/usr/bin/rclone mount acd:Encrypted /home/kamos/acd/.cloud --read-only --allow-other &

# Setup ENCFS
#sudo ENCFS6_CONFIG='/home/kamos/acd/encfs6.xml' encfs --extpass='echo ' --public /home/kamos/acd/.cloud /home/kamos/acd/cloud

# Mount ACD Crypt
#/usr/bin/rclone mount gdrive: /home/kamos/media --read-only --allow-other &
#/bin/bash /home/kamos/scripts/rclonemount.sh

# Setup Unionfs-Fuse
/bin/bash /home/kamos/scripts/unionfs-fuse.sh
