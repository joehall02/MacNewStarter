#!/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

PACKAGE_TOOLS_FILE="../lists/packages.txt"

# Check brew is installed
if ! check_brew_is_installed; then
    exit 1
fi

# Install additional packages from the PACKAGE_TOOLS_FILE file
if [ -f "$PACKAGE_TOOLS_FILE" ]; then
    while IFS= read -r package; do
        install_via_brew "$package"
    done < "$PACKAGE_TOOLS_FILE"
    log_success "🎉 Additional packages installation completed."
else
    log_error "No packages.txt file found."
fi