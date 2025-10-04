#!/bin/bash
source "$(dirname "$0")/../utils/helpers.sh"

# Default Zap install location
ZAP_DIR="$HOME/.local/share/zap"

# Check if Zap is already installed
if [ -d "$ZAP_DIR" ]; then
    log_info "Zap is already installed at $ZAP_DIR"
else
    log_info "Installing Zap Zsh plugin manager..."
    zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

    # Confirm installation
    if [ -d "$ZAP_DIR" ]; then
        log_success "🎉 Zap installed successfully at $ZAP_DIR"
    else
        log_error "Zap installation failed"
        exit 1
    fi
fi
