#!/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

GUI_APPS_FILE="../lists/gui-apps.txt"

# Install gui apps from the GUI_APPS_FILE file
if [ -f "$GUI_APPS_FILE" ]; then
    while IFS= read -r app; do
        install_brew_gui_app "$app"
    done < "$GUI_APPS_FILE"
    echo "GUI applications installation completed."
else
    echo "No gui-apps.txt file found"
fi