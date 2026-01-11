#!/usr/bin/env bash

source "$(dirname "$0")/../utils/helpers.sh"

if ! check_bash_version; then
    exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
VSCODE_SETTINGS_DIR="$PROJECT_ROOT/vscode"
HOME_VSCODE_SETTINGS_DIR="$HOME/.config/Code/User"

setup_vscode_settings() {
    log_info "Setting up vscode settings..."
    
    # Check if vscode settings directory exists in project
    if [[ ! -d "$VSCODE_SETTINGS_DIR" ]]; then
        log_warning "VSCode settings directory not found: $VSCODE_SETTINGS_DIR"
        exit 0
    fi
    
    # Iterate through settings files in vscode/
    for settings_file in "$VSCODE_SETTINGS_DIR"/*; do
        source_file="$settings_file"
        target_file="$HOME_VSCODE_SETTINGS_DIR/$(basename "$settings_file")"

        if [[ -f "$source_file" ]]; then
            create_symlink "$source_file" "$target_file"
        else
            log_warning "Setting file $(basename "$settings_file") not found in $VSCODE_SETTINGS_DIR, skipping..."
        fi
    done
}

main() {
    # Confirm vscode settings setup
    if ! confirm_action "setting up vscode settings"; then
        exit 0
    fi
    
    log_info "Starting vscode settings setup..."

    if setup_vscode_settings; then
        log_success "🎉 VSCode settings setup completed!"
        log_info "All changes to vscode settings will now be git tracked in this repository"
        log_info "VSCode settings are stored in: $VSCODE_SETTINGS_DIR"
        log_info "Home directory vscode settings are symlinked to the project"
    else 
        log_error "VSCode settings setup failed — missing or invalid directory."
    fi
}

main "$@"