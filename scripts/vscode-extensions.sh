#!/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

VSCODE_EXTENSIONS_FILE="../lists/vscode-extensions.txt"

# CHeck VSCode is installed
if ! check_vs_code_is_installed; then
    exit 1
fi

# Install vscode-extensions from the VSCODE_EXTENSIONS_FILE file
if [ -f "$VSCODE_EXTENSIONS_FILE" ]; then
    while IFS= read -r extension; do
        install_vscode_extension "$extension"
    done < "$VSCODE_EXTENSIONS_FILE"
    log_success "🎉 VSCode extensions installation completed."
else
    log_error "No vscode-extensions.txt file found"
fi

