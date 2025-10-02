#!/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

# Install additional packages from the config/packages.txt file
if [ -f "../config/packages.txt" ]; then
    while IFS= read -r package; do
        install_via_brew "$package"
    done < "../config/packages.txt"
else
    echo "No packages.txt file found."
fi