#!/bin/bash
/usr/bin/rclone mount acd:Encrypted /home/$USER/acd/.cloud --read-only --allow-other &
sudo ENCFS6_CONFIG='/home/$USER/acd/encfs6.xml' encfs --extpass='echo ' --public /home/$USER/acd/.cloud /home/$USER/acd/cloud
/usr/bin/rclone mount acdcrypt: /home/$USER/media --read-only --allow-other &
unionfs-fuse -o cow -o allow_other /home/$USER/.media=RW:/home/$USER/media=RO /home/$USER/cloud
