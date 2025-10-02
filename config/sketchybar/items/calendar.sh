#!bin/bash

sketchybar --add item calendar right \
 --set calendar icon=􀉉 \
 label.width=170 \
 update_freq=1 \
 background.color=$CALENDAR_COLOR \
 script="$PLUGIN_DIR/calendar.sh"
