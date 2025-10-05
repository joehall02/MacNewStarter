#!/opt/homebrew/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

if ! check_bash_version; then
    exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
CONFIG_DIR="$PROJECT_ROOT/configs"
HOME_CONFIG_DIR="$HOME/.config"

setup_config_files() {
    log_info "Setting up config files..."
    
    # Create .config directory if it doesn't exist
    mkdir -p "$HOME_CONFIG_DIR"
    
    # Check if .config directory exists in home directory
    if [[ ! -d "$HOME_CONFIG_DIR" ]]; then
        log_warning ".config directory not found: $HOME_CONFIG_DIR"
        log_info "Creating .config directory..."
        mkdir -p "$HOME_CONFIG_DIR"
    fi

    # Check if config directory exists in project
    if [[ ! -d "$CONFIG_DIR" ]]; then
        log_warning "Config directory not found: $CONFIG_DIR"
        exit 0
    fi
    
    # Iterate through all directories and files in config/
    for config_item in "$CONFIG_DIR"/*; do
        if [[ -d "$config_item" ]]; then
            config_name=$(basename "$config_item")
            source_config="$config_item"
            target_config="$HOME_CONFIG_DIR/$config_name"
            
            log_info "Setting up config directory: $config_name"
            
            # Remove existing config directory/symlink
            if [[ -L "$target_config" ]]; then
                log_info "Removing existing symlink: $target_config"
                rm "$target_config"
            elif [[ -d "$target_config" ]]; then
                local backup="${target_config}.backup_$(date +%Y%m%d%H%M%S)"
                log_warning "Backing up existing directory: $target_config to $backup"
                mv "$target_config" "$backup"
            fi
            
            # Create symlink
            ln -s "$source_config" "$target_config"
            log_success "Created config symlink: $target_config -> $source_config"
            
        elif [[ -f "$config_item" ]]; then
            config_name=$(basename "$config_item")
            source_config="$config_item"
            target_config="$HOME_CONFIG_DIR/$config_name"
            
            log_info "Setting up config file: $config_name"
            
            # Handle existing config file
            if [[ -L "$target_config" ]]; then
                log_info "Removing existing symlink: $target_config"
                rm "$target_config"
            elif [[ -f "$target_config" ]]; then
                local backup="${target_config}.backup_$(date +%Y%m%d%H%M%S)"
                log_warning "Backing up existing file: $target_config to $backup"
                mv "$target_config" "$backup"
            fi
            
            # Create symlink
            ln -s "$source_config" "$target_config"
            log_success "Created config symlink: $target_config -> $source_config"
        fi
    done
}

main() {
    # Confirm config files setup
    if ! confirm_action "setting up config files"; then
        exit 0
    fi
    
    log_info "Starting config files setup..."

    if setup_config_files; then
        log_success "🎉 Config files setup completed!"
        log_info "All changes to config files will now be git tracked in this repository"
        log_info "Config files are stored in: $CONFIG_DIR"
        log_info "~/.config files are symlinked to the project"
    else
        log_error "Configs setup failed - missing or invalid directory."
    fi
}

main "$@"