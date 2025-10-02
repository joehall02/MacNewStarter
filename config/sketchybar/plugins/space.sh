#!/bin/bash

source "$CONFIG_DIR/colours.sh" # Loads all defined colors

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.drawing=on \
                         background.color=$ACCENT_COLOR \
                         label.color=$WHITE \
                         icon.color=$WHITE
else
  sketchybar --set $NAME background.drawing=on \
                         background.color=$BLACK \
                         label.color=$WHITE \
                         icon.color=$WHITE
fi