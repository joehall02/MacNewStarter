#!/usr/bin/env bash

source "$(dirname "$0")/utils/helpers.sh"

# Main installation script for macOS setup
if [[ "${BASH_VERSINFO[0]}" -lt 4 ]]; then
    log_warning "Warning: Bash 3 detected. Some features may not work optimally."
    log_warning "Run the Bash upgrade script or run everything to install a newer version via Homebrew."
fi

# Function to install xcode command line tools
install_xcode_cli_tools() {
    ./scripts/xcode-cli-tools.sh
}

# Function to install Homebrew
install_homebrew() {
    ./scripts/homebrew.sh
}

# Function to upgrade bash
upgrade_bash() {
    ./scripts/upgrade-bash.sh
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
echo "1 ) Install everything (Recommended)"
echo "2 ) Install Xcode Command Line Tools"
echo "3 ) Install Homebrew"
echo "4 ) Upgrade Bash"
echo "5 ) Install CLI Tools"
echo "6 ) Install Packages"
echo "7 ) Install GUI Apps"
echo "8 ) Install VSCode Extensions"
echo "9 ) Install Zap ZSH"
echo "10) Setup Dotfiles"
echo "11) Setup Configs"
echo "12) Quit"
echo

# --- Read User Input ---
read -rp "Enter: " choice
echo

# --- Execute Based on Choice ---
case "$choice" in
    1)
        install_xcode_cli_tools
        install_homebrew
        upgrade_bash
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
    4) upgrade_bash ;;
    5) install_cli_tools ;;
    6) install_packages ;;
    7) install_gui_apps ;;
    8) install_vscode_extensions ;;
    9) install_zap_zsh ;;
    10) setup_dotfiles ;;
    11) setup_configs ;;
    12) 
        echo "Exiting..."
        exit 0 ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

log_success "🎉 MacNewStarter setup installation completed!"
echo "Exiting..."
exit 0