#!/bin/sh -xu

# Input Parameters
ARG_PATH="$1"
ARG_NAME="$2"
ARG_LABEL="$3"

# Configuration
CONFIG_OUTPUT="/home/kamos/cloud"

# Run Filebot
sudo filebot -script fn:amc --output "$CONFIG_OUTPUT" --action copy --conflict auto -non-strict -no-xattr --log-file /home/kamos/logs/amc.log --def clean=y unsorted=y music=y artwork=y ut_dir="$ARG_PATH" ut_kind="multi" ut_title="$ARG_NAME" ut_label="$ARG_LABEL" --def "seriesFormat=tv/{n}/Season {s.pad(2)}/{n} - {s00e00} - {t}" "movieFormat=movies/{ny}/{ny}" "unsortedFormat=/home/kamos/unsorted/{file.name}" &
