#!/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
CLI_TOOLS_FILE="$SCRIPT_DIR/../lists/cli-tools.txt"

# Check brew is installed
if ! check_brew_is_installed; then
    exit 1
fi

# Confirm installation
if ! confirm_action "installing CLI Tools"; then
    exit 0
fi

# Install cli tools from the CLI_TOOLS_FILE file
if [ -f "$CLI_TOOLS_FILE" ]; then
    while IFS= read -r cli_tool || [ -n "$cli_tool" ]; do
        [[ -z "$cli_tool" || "$cli_tool" =~ ^# ]] && continue
        install_via_brew "$cli_tool"
    done < "$CLI_TOOLS_FILE"
    log_success "🎉 CLI tools installation completed."
else
    log_error "No cli-tools.txt file found."
fi