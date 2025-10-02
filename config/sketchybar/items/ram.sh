#!/bin/bash

sketchybar --add item ram right \
 --set ram update_freq=2 \
 icon=􀫦 \
 label.width=60 \
 background.color=$RAM_COLOR \
 script="$PLUGIN_DIR/ram.sh" \
