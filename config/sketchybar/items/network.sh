#!/bin/bash

network_down=(
	icon=􀄩
	update_freq=1
)

network_up=(
	icon=􀄨
	update_freq=1
	script="$PLUGIN_DIR/network.sh"
)

sketchybar 	--add item network.down right 						\
						--set network.down "${network_down[@]}" 	\
						--add item network.up right 							\
						--set network.up "${network_up[@]}"

