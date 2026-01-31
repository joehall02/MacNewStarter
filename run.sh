#!/usr/bin/env bash

# Gets root dir of MacNewStarter
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$(dirname "$0")/utils/helpers.sh"

# Main installation script for macOS setup
if [[ "${BASH_VERSINFO[0]}" -lt 4 ]]; then
    log_warning "Warning: Bash 3 detected. Some features may not work optimally."
    log_warning "Run the Bash upgrade script or run everything to install a newer version via Homebrew."
    echo
fi

# Function to install xcode command line tools
install_xcode_cli_tools() {
    $ROOT_DIR/scripts/xcode-cli-tools.sh
}

# Function to install Homebrew
install_homebrew() {
    $ROOT_DIR/scripts/homebrew.sh
}

# Function to upgrade bash
upgrade_bash() {
    $ROOT_DIR/scripts/upgrade-bash.sh
}

# Function to install command line tools
install_cli_tools() {
    $ROOT_DIR/scripts/cli-tools.sh
}

# Function to install additional packages
install_packages() {
    $ROOT_DIR/scripts/packages.sh
}

# Function to install zap zsh
install_zap_zsh() {
    $ROOT_DIR/scripts/zap-zsh.sh
}

# Function to install oh my zsh
install_oh_my_zsh() {
    $ROOT_DIR/scripts/oh-my-zsh-install.sh
}

# Function to setup dotfiles
setup_dotfiles() {
    $ROOT_DIR/scripts/dotfiles.sh
}

# Function to setup config files
setup_configs() {
    $ROOT_DIR/scripts/configs.sh
}

# Function to setup docker symlinking
setup_docker() {
    $ROOT_DIR/scripts/docker.sh
}

# Function to setup vscode settings symlinking
setup_vscode_settings() {
    $ROOT_DIR/scripts/vscode-settings.sh
}

# Function to setup cursor settings symlinking
setup_cursor_settings() {
    $ROOT_DIR/scripts/cursor-settings.sh
}

# Function to install VSCode extensions
install_vscode_extensions() {
    $ROOT_DIR/scripts/vscode-extensions.sh
}

# Function to install Cursor extensions
install_cursor_extensions() {
    $ROOT_DIR/scripts/cursor-extensions.sh
}

# Function to install GUI applications
install_gui_apps() {
    $ROOT_DIR/scripts/gui-apps.sh
}

backup_docker_services() {
    $ROOT_DIR/utils/docker-backups.sh
}

print_help() {
    cat <<EOF
Usage: mns <command>

Commands:
  setup-dotfiles         Setup dotfiles via symlinks 
  setup-configs          Setup configs via symlinks
  setup-docker           Setup Docker symlinks
  setup-vscode-settings  Setup VSCode settings symlinks
  setup-cursor-settings  Setup Cursor settings symlinks
  install-cli-tools      Install CLI tools
  install-packages       Install extra packages
  install-gui-apps       Install GUI applications
  install-vscode-exts    Install VSCode extensions
  install-cursor-exts    Install Cursor extensions
  install-homebrew       Install Homebrew
  install-xcode-cli      Install Xcode Command Line Tools
  install-zap-zsh        Install Zap ZSH
  install-oh-my-zsh      Install Oh My Zsh
  upgrade-bash           Upgrade Bash via Homebrew script
  all                    Run full recommended setup (everything)
  help                   Show help message

Utils:
  docker-backups         Create backups of docker services

With no arguments, an interactive menu is shown.
EOF
}

run_subcommand() {
    local cmd="$1"
    
    # Removes first argument of the command and shifts along in the array to take its place
    # Passes without error if no arguments exist
    shift || true 

    # "$@" passes remaining command line arguments to the function
    case "$cmd" in
        setup-dotfiles)         setup_dotfiles "$@" ;;
        setup-configs)          setup_configs "$@" ;;
        setup-docker)           setup_docker "$@" ;;
        setup-vscode-settings)  setup_vscode_settings "$@" ;;
        setup-cursor-settings)  setup_cursor_settings "$@" ;;
        install-cli-tools)      install_cli_tools "$@" ;;
        install-packages)       install_packages "$@" ;;
        install-gui-apps)       install_gui_apps "$@" ;;
        install-vscode-exts)    install_vscode_extensions "$@" ;;
        install-cursor-exts)    install_cursor_extensions "$@" ;;
        install-homebrew)       install_homebrew "$@" ;;
        install-xcode-cli)      install_xcode_cli_tools "$@" ;;
        install-zap-zsh)        install_zap_zsh "$@" ;;
        install-oh-my-zsh)      install_oh_my_zsh "$@" ;;
        upgrade-bash)           upgrade_bash "$@" ;;
        docker-backups)         backup_docker_services "$@" ;;
        all)
            install_xcode_cli_tools
            install_homebrew
            upgrade_bash
            install_cli_tools
            install_packages
            install_gui_apps
            install_vscode_extensions
            install_cursor_extensions
            install_zap_zsh
            install_oh_my_zsh
            setup_dotfiles
            setup_configs
            setup_docker
            setup_vscode_settings
            setup_cursor_settings
            ;;
        help|-h|--help|"")
            print_help
            return 0
            ;;
        *)
            log_error "Unknown command: $cmd"
            echo
            print_help
            return 1
            ;;
    esac

    log_success "🎉 Command '$cmd' completed!"
}

show_menu_and_run() {
    echo
    echo "Welcome to MacNewStarter!"
    echo

    echo "Enter one of the following numbers to get started:"
    echo "1 ) Install everything (Recommended)"
    echo "2 ) Install Xcode Command Line Tools"
    echo "3 ) Install Homebrew"
    echo "4 ) Upgrade Bash"
    echo "5 ) Install CLI Tools"
    echo "6 ) Install Packages"
    echo "7 ) Install GUI Apps"
    echo "8 ) Install VSCode Extensions"
    echo "9 ) Install Cursor Extensions"
    echo "10 ) Install Zap ZSH"
    echo "11 ) Install Oh My Zsh"
    echo "12 ) Setup Dotfiles"
    echo "13 ) Setup Configs"
    echo "14 ) Setup Docker"
    echo "15 ) Setup VSCode Settings"
    echo "16 ) Setup Cursor Settings"
    echo "17 ) Quit"
    echo

    read -rp "Enter: " choice
    echo

    case "$choice" in
        1)
            install_xcode_cli_tools
            install_homebrew
            upgrade_bash
            install_cli_tools
            install_packages
            install_gui_apps
            install_vscode_extensions
            install_cursor_extensions
            install_zap_zsh
            install_oh_my_zsh
            setup_dotfiles
            setup_configs
            setup_docker
            setup_vscode_settings
            setup_cursor_settings
            ;;
        2) install_xcode_cli_tools ;;
        3) install_homebrew ;;
        4) upgrade_bash ;;
        5) install_cli_tools ;;
        6) install_packages ;;
        7) install_gui_apps ;;
        8) install_vscode_extensions ;;
        9) install_cursor_extensions ;;
        10) install_zap_zsh ;;
        11) install_oh_my_zsh ;;
        12) setup_dotfiles ;;
        13) setup_configs ;;
        14) setup_docker ;;
        15) setup_vscode_settings ;;
        16) setup_cursor_settings ;;
        17)
            echo "Exiting..."
            return 0
            ;;
        *)
            echo "Invalid choice. Exiting."
            return 1
            ;;
    esac

    log_success "🎉 MacNewStarter setup installation completed!"
    echo "Exiting..."
}

main() {
    # Check if at least 1 command line argument was passed
    if [[ $# -gt 0 ]]; then
        run_subcommand "$@"
    else
        show_menu_and_run
    fi
}

main "$@"
