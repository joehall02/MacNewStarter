#!/opt/homebrew/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

if ! check_bash_version; then
    exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
DOCKER_DIR="$PROJECT_ROOT/docker"
HOME_DOCKER_DIR="$HOME/Docker"

setup_docker_files() {
    log_info "Setting up docker files..."

    # Check if docker directory exists in home directory
    if [[ ! -d "$HOME_DOCKER_DIR" ]]; then
        log_warning "Docker home directory not found: $HOME_DOCKER_DIR"
        log_info "Creating Docker directory..."
        mkdir -p "$HOME_DOCKER_DIR"
    fi 

    # Check if docker directory exists in project
    if [[ ! -d "$DOCKER_DIR" ]]; then
        log_warning "Docker directory not found: $DOCKER_DIR"
        exit 0
    fi

    # Iterate through all directories and files in docker/
    for docker_item in "$DOCKER_DIR"/*; do
        if [[ -d "$docker_item" ]]; then
            docker_config_name=$(basename "$docker_item")
            source_docker_config="$docker_item"
            target_docker_config="$HOME_DOCKER_DIR/$docker_config_name"
            
            log_info "Setting up docker directory: $docker_config_name"
            
            # Remove existing docker directory/symlink
            if [[ -L "$target_docker_config" ]]; then
                log_info "Removing existing symlink: $target_docker_config"
                rm "$target_docker_config"
            elif [[ -d "$target_docker_config" ]]; then
                local backup="${target_docker_config}.backup_$(date +%Y%m%d%H%M%S)"
                log_warning "Backing up existing directory: $target_docker_config to $backup"
                mv "$target_docker_config" "$backup"
            fi
            
            # Create symlink
            ln -s "$source_docker_config" "$target_docker_config"
            log_success "Created docker folder symlink: $target_docker_config -> $source_docker_config"
            
        elif [[ -f "$docker_item" ]]; then
            docker_config_name=$(basename "$docker_item")
            source_docker_config="$docker_item"
            target_docker_config="$HOME_DOCKER_DIR/$docker_config_name"
            
            log_info "Setting up docker file: $docker_config_name"
            
            # Handle existing docker file
            if [[ -L "$target_docker_config" ]]; then
                log_info "Removing existing symlink: $target_docker_config"
                rm "$target_docker_config"
            elif [[ -f "$target_docker_config" ]]; then
                local backup="${target_docker_config}.backup_$(date +%Y%m%d%H%M%S)"
                log_warning "Backing up existing file: $target_docker_config to $backup"
                mv "$target_docker_config" "$backup"
            fi
            
            # Create symlink
            ln -s "$source_docker_config" "$target_docker_config"
            log_success "Created docker file symlink: $target_docker_config -> $source_docker_config"
        fi
    done
}

main() {
    # Confirm docker files setup
    if ! confirm_action "setting up docker files"; then
        exit 0
    fi
    
    log_info "Starting docker files setup..."

    if setup_docker_files; then
        log_success "🎉 Docker files setup completed!"
        log_info "All changes to docker files will now be git tracked in this repository"
        log_info "Docker files are stored in: $DOCKER_DIR"
        log_info "~/Docker files are symlinked to the project"
    else
        log_error "Docker file setup failed - missing or invalid directory."
    fi
}

main "$@"