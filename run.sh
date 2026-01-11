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

# Function to install VSCode extensions
install_vscode_extensions() {
    $ROOT_DIR/scripts/vscode-extensions.sh
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
  install-cli-tools      Install CLI tools
  install-packages       Install extra packages
  install-gui-apps       Install GUI applications
  install-vscode-exts    Install VSCode extensions
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
        install-cli-tools)      install_cli_tools "$@" ;;
        install-packages)       install_packages "$@" ;;
        install-gui-apps)       install_gui_apps "$@" ;;
        install-vscode-exts)    install_vscode_extensions "$@" ;;
        install-zap-zsh)        install_zap_zsh "$@" ;;
        install-oh-my-zsh)      install_oh_my_zsh "$@" ;;
        upgrade-bash)           upgrade_bash "$@" ;;
        docker-backups)         backup_docker_services "$@" ;;
        all)
            upgrade_bash
            install_cli_tools
            install_packages
            install_gui_apps
            install_vscode_extensions
            install_zap_zsh
            install_oh_my_zsh
            setup_dotfiles
            setup_configs
            setup_docker
            setup_vscode_settings
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
    echo "2 ) Upgrade Bash"
    echo "3 ) Install CLI Tools"
    echo "4 ) Install Packages"
    echo "5 ) Install GUI Apps"
    echo "6 ) Install VSCode Extensions"
    echo "7 ) Install Zap ZSH"
    echo "8 ) Install Oh My Zsh"
    echo "9 ) Setup Dotfiles"
    echo "10 ) Setup Configs"
    echo "11 ) Setup Docker"
    echo "12 ) Setup VSCode Settings"
    echo "13 ) Quit"
    echo

    read -rp "Enter: " choice
    echo

    case "$choice" in
        1)
            upgrade_bash
            install_cli_tools
            install_packages
            install_gui_apps
            install_vscode_extensions
            install_zap_zsh
            install_oh_my_zsh
            setup_dotfiles
            setup_configs
            setup_docker
            setup_vscode_settings
            ;;
        2) upgrade_bash ;;
        3) install_cli_tools ;;
        4) install_packages ;;
        5) install_gui_apps ;;
        6) install_vscode_extensions ;;
        7) install_zap_zsh ;;
        8) install_oh_my_zsh ;;
        9) setup_dotfiles ;;
        10) setup_configs ;;
        11) setup_docker ;;
        12) setup_vscode_settings ;;
        13)
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
