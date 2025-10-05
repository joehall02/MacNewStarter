#!/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

# Install xcode cli tools
if ! xcode-select -p &>/dev/null; then
    # Confirm installation
    if ! confirm_action "installing Xcode CLI tools"; then
        exit 0
    fi

    log_info "Installing Xcode command line tools..."
    xcode-select --install

    # Wait until installed
    until xcode-select -p &>/dev/null; do
        sleep 5
    done

    log_success "🎉 Xcode command line tools installation completed."
else
    log_info "Xcode command line tools already installed."
fi