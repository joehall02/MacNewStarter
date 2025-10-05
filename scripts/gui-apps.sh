#!/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

if ! check_bash_version; then
    exit 0
fi

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
GUI_APPS_FILE="$SCRIPT_DIR/../lists/gui-apps.txt"

# Check brew is installed
if ! check_brew_is_installed; then
    exit 1
fi

# Confirm installation
if ! confirm_action "installing GUI apps"; then
    exit 0
fi

# Install gui apps from the GUI_APPS_FILE file
if [ -f "$GUI_APPS_FILE" ]; then
    while IFS= read -r app || [ -n "$app" ]; do
        [[ -z "$app" || "$app" =~ ^# ]] && continue
        install_brew_gui_app "$app"
    done < "$GUI_APPS_FILE"
    log_success "🎉 GUI applications installation completed."
else
    log_error "No gui-apps.txt file found"
fi