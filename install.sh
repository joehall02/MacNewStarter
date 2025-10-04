#!/bin/bash

source "$(dirname "$0")/utils/helpers.sh"

# Main installation script for macOS setup

# Function to install xcode command line tools
install_xcode_cli_tools() {
    ./scripts/xcode-cli-tools.sh
}

# Function to install Homebrew
install_homebrew() {
    ./scripts/homebrew.sh
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
    ./scripts/vscode-extensions.sh
}

# Function to install GUI applications
install_gui_apps() {
    ./scripts/gui-apps.sh
}

# Welcome
echo "Welcome to MacNewStarter!"
echo

# Menu
echo "Enter one of the following numbers to get started:"
echo "1) Install everything (Recommended)"
echo "2) Install Xcode Command Line Tools"
echo "3) Install Homebrew"
echo "4) Install CLI Tools"
echo "5) Install Packages"
echo "6) Install GUI Apps"
echo "7) Install VSCode Extensions"
echo "8) Install Zap ZSH"
echo "9) Setup Dotfiles"
echo "10) Setup Configs"
echo

# --- Read User Input ---
read -rp "Enter: " choice
echo

# --- Execute Based on Choice ---
case "$choice" in
    1)
        install_xcode_cli_tools
        install_homebrew
        install_cli_tools
        install_packages
        install_gui_apps
        install_vscode_extensions
        install_zap_zsh
        setup_dotfiles
        setup_configs
        ;;
    2) install_xcode_cli_tools ;;
    3) install_homebrew ;;
    4) install_cli_tools ;;
    5) install_packages ;;
    6) install_gui_apps ;;
    7) install_vscode_extensions ;;
    8) install_zap_zsh ;;
    9) setup_dotfiles ;;
    10) setup_configs ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

log_success "🎉 MacNewStarter setup installation completed!"