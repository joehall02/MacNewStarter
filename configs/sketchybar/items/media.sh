#!/bin/bash

sketchybar --add item media centre \
           --set media label.color=$WHITE \
                       label.max_chars=30 \
                       icon.padding_left=10 \
                       icon.padding_right=10 \
                       scroll_texts=on \
                       icon=􀑪             \
                       icon.color=$WHITE   \
                       background.drawing=on \
                       background.color=$BLACK \
                       script="$PLUGIN_DIR/media.sh" \
           --subscribe media media_change
