#!/bin/bash

sketchybar --add item volume right \
 --set volume script="$PLUGIN_DIR/volume.sh" \
 label.width=60 \
 background.color=$VOLUME_COLOR \
 --subscribe volume volume_change \
