#!/opt/homebrew/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

if ! check_bash_version; then
    exit 0
fi

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
BREWFILE="$SCRIPT_DIR/../lists/Brewfile.cli"

# Check brew is installed
if ! check_brew_is_installed; then
    exit 1
fi

# Confirm installation
if ! confirm_action "installing CLI Tools"; then
    exit 0
fi

if ! install_via_brewfile "$BREWFILE" "CLI tools"; then
    exit 1
fi

log_success "🎉 CLI tools installation completed."
