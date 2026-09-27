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

    # Installed directly rather than via a Brewfile: this is a bootstrap step that
    # runs under system Bash 3.2, before the Brewfiles are used, for one formula.
    if brew list --formula bash >/dev/null 2>&1; then
        log_info "bash is already installed via Homebrew."
    else
        log_info "Installing bash..."
        if ! brew install bash; then
            log_error "Failed to install bash via Homebrew."
            exit 1
        fi
    fi

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
