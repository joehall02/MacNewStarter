#!/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
PACKAGE_TOOLS_FILE="$SCRIPT_DIR/../lists/packages.txt"

# Check brew is installed
if ! check_brew_is_installed; then
    exit 1
fi

# Confirm installation
if ! confirm_action "installing Packages"; then
    exit 0
fi

# Install additional packages from the PACKAGE_TOOLS_FILE file
if [ -f "$PACKAGE_TOOLS_FILE" ]; then
    while IFS= read -r package || [ -n "$package" ]; do
        [[ -z "$package" || "$package" =~ ^# ]] && continue
        install_via_brew "$package"
    done < "$PACKAGE_TOOLS_FILE"
    log_success "🎉 Additional packages installation completed."
else
    log_error "No packages.txt file found."
fi