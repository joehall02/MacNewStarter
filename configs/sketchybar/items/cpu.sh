#!/bin/bash

sketchybar --add item cpu right \
 --set cpu update_freq=2 \
 icon=􀫥 \
 label.width=60 \
 background.color=$CPU_COLOR \
 script="$PLUGIN_DIR/cpu.sh" \
