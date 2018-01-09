#!/bin/bash

# Setup Unionfs-Fuse
unionfs-fuse \
-o cow,allow_other,direct_io,auto_cache,sync_read \
/home/kamos/.media=RW:/home/kamos/media=RO /home/kamos/cloud

