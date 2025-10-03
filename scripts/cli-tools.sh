#!/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

# Read the list of command line tools from the config file
CLI_TOOLS_FILE="../lists/cli-tools.txt"

# Install cli tools from the CLI_TOOLS_FILE file
if [ -f "$CLI_TOOLS_FILE" ]; then
    while IFS= read -r cli_tool; do
        install_via_brew "$cli_tool"
    done < "$CLI_TOOLS_FILE"
    echo "CLI tools installation completed."
else
    echo "No cli-tools.txt file found."
fi