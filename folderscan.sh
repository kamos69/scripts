#!/bin/bash -xu
## To determine sections run $LD_LIBRARY_PATH/Plex\ Media\ Scanner --list

# Input
ARG_PATH="$1"

# Environment Variables
export LD_LIBRARY_PATH=/usr/lib/plexmediaserver
export PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR=/var/lib/plexmediaserver/Library/Application\ Support

# Display list
$LD_LIBRARY_PATH/Plex\ Media\ Scanner --list

# Read input
echo "Please select section to scan."

read SECTION
echo "You selected $SECTION"

# Scan Folder
echo "Scanning folder $ARG_PATH in section $SECTION"
$LD_LIBRARY_PATH/Plex\ Media\ Scanner -s -r -c "$SECTION" -d "$ARG_PATH"

exit
