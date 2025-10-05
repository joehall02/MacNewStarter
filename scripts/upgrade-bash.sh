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

    log_info "Installing latest Bash via Homebrew..."
    brew install bash

    BREW_BASH="$(brew --prefix)/bin/bash"

    # Temporarily prioritize Homebrew Bash in PATH for this session
    export PATH="$(dirname "$BREW_BASH"):$PATH"

    # Verify that the new Bash is being used
    log_info "Current Bash version: $(bash --version | head -n 1)"

    log_success "Latest Bash installed at $BREW_BASH"
else
    log_info "Compatible Bash version already installed"
fi
