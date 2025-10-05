#!/usr/bin/env bash
source "$(dirname "$0")/../utils/helpers.sh"

# Check and upgrade Bash if needed
if ! check_bash_version; then    
    # Ensure Homebrew is installed
    if ! check_brew_is_installed; then
        exit 1
    fi

    if ! confirm_action "upgrading Bash"; then
        exit 0
    fi

    install_via_brew bash

    BREW_BASH="$(brew --prefix)/bin/bash"

    # Verify installation
    if [[ ! -x "$BREW_BASH" ]]; then
        log_error "Homebrew Bash installation failed."
        exit 1
    fi

    # Temporarily prioritise Homebrew Bash in PATH for this session
    export PATH="$(dirname "$BREW_BASH"):$PATH"

    log_success "Latest Bash installed at $BREW_BASH"
    log_info "Current Bash version: $(bash --version | head -n 1)"

    # Replace current shell with the new Bash for the rest of the script
    log_info "Switching current shell to Homebrew Bash..."
    exec "$BREW_BASH" "$0" "$@"
else
    log_info "Compatible Bash version already installed"
fi
