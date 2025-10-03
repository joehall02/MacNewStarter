#!/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

PACKAGE_TOOLS_FILE="../lists/packages.txt"

# Install additional packages from the PACKAGE_TOOLS_FILE file
if [ -f "$PACKAGE_TOOLS_FILE" ]; then
    while IFS= read -r package; do
        install_via_brew "$package"
    done < "$PACKAGE_TOOLS_FILE"
    echo "Additional packages installation completed."
else
    echo "No packages.txt file found."
fi