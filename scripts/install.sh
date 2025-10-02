#!/bin/bash

# Main installation script for macOS setup

# Function to install GUI applications
# install_gui_apps() {
#     ./scripts/gui-apps.sh
# }

# Function to install command line tools
# install_cli_tools() {
#     ./scripts/cli-tools.sh
# }

# Function to install additional packages
install_packages() {
    ./scripts/packages.sh
}

# Function to setup dotfiles
setup_dotfiles() {
    ./scripts/setup-dotfiles.sh
}

# Function to setup config files
setup_configs() {
    ./scripts/setup-configs.sh
}

# Start the installation process
echo "Starting macOS setup installation..."

# install_gui_apps
# install_cli_tools
# install_packages
setup_dotfiles
setup_configs

echo "macOS setup installation completed!"