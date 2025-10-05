#!/bin/bash
source "$(dirname "$0")/../utils/helpers.sh"

# Install Homebrew if missing
if ! command -v brew &> /dev/null; then
    # Confirm installation
    if ! confirm_installation "Homebrew"; then
        exit 0
    fi

    log_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Determine Homebrew path (Apple Silicon or Intel Mac)
    BREW_PATH="/opt/homebrew/bin/brew"
    if [[ ! -x "$BREW_PATH" ]]; then
        BREW_PATH="/usr/local/bin/brew"
    fi
    
    # Check installation succeeded
    if [[ ! -x "$BREW_PATH" ]]; then
        log_error "Homebrew installation failed."
        exit 1
    fi

    # Update PATH for current shell
    eval "$($BREW_PATH shellenv)"
    log_info "Homebrew path: $(which brew)"
    log_success "🎉 Homebrew installation completed"
else
    log_info "Homebrew already installed."
fi
