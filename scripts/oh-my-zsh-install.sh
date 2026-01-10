#!/opt/homebrew/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

if ! check_bash_version; then
    exit 0
fi

# OMZ install location
OMZ_DIR="$HOME/.oh-my-zsh/"

# Check if OMZ is already installed
if [ -d "$OMZ_DIR" ]; then
    log_info "Oh My Zsh is already installed at $OMZ_DIR"
else
    # Confirm installation
    if ! confirm_action "installing Oh My Zsh"; then
        exit 0
    fi

    log_info "Installing Oh My Zsh..."
    
    # Prevent exec zsh, stop default shell prompts, never overwrite .zshrc, install oh-my-zsh
    # Allows MacNewStarter scripts without being interrupted by oh-my-zsh
    RUNZSH=no \
    CHSH=no \
    KEEP_ZSHRC=yes \
    ZSH="$OMZ_DIR" \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # Confirm installation
    if [ -d "$OMZ_DIR" ]; then
        log_success "🎉 Oh My Zsh installed successfully at $OMZ_DIR"
    else
        log_error "Oh My Zsh installation failed"
        exit 1
    fi
fi
