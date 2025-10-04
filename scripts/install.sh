#!/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

# Main installation script for macOS setup

# Function to install xcode command line tools
install_xcode_cli_tools() {
    .scripts/xcode-cli-tools.sh
}

# Function to install Homebrew
install_homebrew() {
    .scripts/homebrew.sh
}

# Function to install command line tools
install_cli_tools() {
    ./scripts/cli-tools.sh
}

# Function to install additional packages
install_packages() {
    ./scripts/packages.sh
}

# Function to install zap zsh
install_zap_zsh() {
    ./scripts/zap-zsh.sh
}

# Function to setup dotfiles
setup_dotfiles() {
    ./scripts/dotfiles.sh
}

# Function to setup config files
setup_configs() {
    ./scripts/configs.sh
}

# Function to install VSCode extneions
install_vscode_extensions() {
    /scripts/vscode_extensions.sh
}

# Function to install GUI applications
install_gui_apps() {
    ./scripts/gui-apps.sh
}

# Start the installation process
log_info "Starting MacNewStarter setup installation..."

# install_gui_apps
install_xcode_cli_tools
install_homebrew
install_cli_tools
install_packages
install_gui_apps
install_vscode_extensions
install_zap_zsh
setup_dotfiles
setup_configs

log_success "🎉 MacNewStarter setup installation completed!"