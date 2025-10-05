#!/bin/bash

sketchybar --add item front_app left \
           --set front_app       background.color=$ACCENT_COLOR \
                                 icon.font="sketchybar-app-font:Regular:16.0" \
                                 script="$PLUGIN_DIR/front_app.sh"            \
                                 icon.color=$WHITE \
                                 label.color=$WHITE \
                                 label.padding_left=10 \
                                 label.padding_right=20 \
           --subscribe front_app front_app_switched