#!/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

# Read the list of command line tools from the config file
CLI_TOOLS_FILE="../lists/cli-tools.txt"

# Check brew is installed
if ! check_brew_is_installed; then
    exit 1
fi

# Confirm installation
if ! confirm_installation "CLI Tools"; then
    log_error "Skipping CLI Tools installation..."
    exit 0
fi

# Install cli tools from the CLI_TOOLS_FILE file
if [ -f "$CLI_TOOLS_FILE" ]; then
    while IFS= read -r cli_tool; do
        install_via_brew "$cli_tool"
    done < "$CLI_TOOLS_FILE"
    log_success "🎉 CLI tools installation completed."
else
    log_error "No cli-tools.txt file found."
fi