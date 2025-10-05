#!/opt/homebrew/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

if ! check_bash_version; then
    exit 0
fi

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
VSCODE_EXTENSIONS_FILE="$SCRIPT_DIR/../lists/vscode-extensions.txt"

# CHeck VSCode is installed
if ! check_vs_code_is_installed; then
    exit 1
fi

# Confirm installation
if ! confirm_action "installing VSCode extensions"; then
    exit 0
fi

# Install vscode-extensions from the VSCODE_EXTENSIONS_FILE file
if [ -f "$VSCODE_EXTENSIONS_FILE" ]; then
    while IFS= read -r extension || [ -n "$extension" ]; do
        [[ -z "$extension" || "$extension" =~ ^# ]] && continue
        install_vscode_extension "$extension"
    done < "$VSCODE_EXTENSIONS_FILE"
    log_success "🎉 VSCode extensions installation completed."
else
    log_error "No vscode-extensions.txt file found"
fi