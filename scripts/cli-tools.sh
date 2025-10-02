#!/bin/bash

# Read the list of command line tools from the config file
CLI_TOOLS_FILE="../config/cli-tools.txt"

# Check if the CLI tools file exists
if [[ ! -f "$CLI_TOOLS_FILE" ]]; then
    echo "CLI tools configuration file not found!"
    exit 1
fi

# Install each command line tool listed in the CLI tools file
while IFS= read -r tool; do
    echo "Installing $tool..."
    if command -v "$tool" &> /dev/null; then
        echo "$tool is already installed."
    else
        # Use Homebrew to install the tool
        brew install "$tool"
    fi
done < "$CLI_TOOLS_FILE"