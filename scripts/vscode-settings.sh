#!/opt/homebrew/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

if ! check_bash_version; then
    exit 0
fi

main() {
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
    VSCODE_SETTINGS_URL="$PROJECT_ROOT/vscode"
    HOME_VSCODE_SETTINGS_DIR="$HOME/Library/Application Support/Code/User"
    APP_NAME="VS Code"

    # Confirm vscode settings setup
    if ! confirm_action "setting up $APP_NAME settings"; then
        exit 0
    fi
    
    log_info "Starting $APP_NAME settings setup..."

    if setup_vscode_settings "$VSCODE_SETTINGS_URL" "$HOME_VSCODE_SETTINGS_DIR" "$APP_NAME"; then
        log_success "🎉 $APP_NAME settings setup completed!"
        log_info "All changes to $APP_NAME settings will now be git tracked in this repository"
        log_info "$APP_NAME settings are stored in: $VSCODE_SETTINGS_URL"
        log_info "Home directory $APP_NAME settings are symlinked to the project"
    else 
        log_error "$APP_NAME settings setup failed — missing or invalid directory."
    fi
}

main "$@"