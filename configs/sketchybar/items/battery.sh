#!/bin/bash

sketchybar --add item battery right \
 --set battery update_freq=120 \
 label.width=60 \
 background.color=$BATTERY_COLOR \
 script="$PLUGIN_DIR/battery.sh" \
 --subscribe battery system_woke power_source_change
