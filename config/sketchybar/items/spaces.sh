#!/bin/bash

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        icon=$sid \
        label.font="sketchybar-app-font:Regular:16.0" \
        label.padding_right=7                     \
        icon.padding_left=15                     \
        label.y_offset=-1 \
        click_script="aerospace workspace $sid" \
        script="$PLUGIN_DIR/space.sh $sid"
done
