#!/bin/bash

set -e
source "$(dirname "$0")/../utils/helpers.sh"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
DOTFILES_DIR="$PROJECT_ROOT/dotfiles"

setup_dotfiles() {
    log_info "Setting up dotfiles..."
    
    # Check if dotfile directory exists in project
    if [[ ! -d "$DOTFILE_DIR" ]]; then
        log_warning "Dotfile directory not found: $DOTFILE_DIR"
        return 0
    fi
    
    # Iterate through dotfiles in dotfiles/
    for dotfile in "$DOTFILES_DIR"/*; do
        source_file="$DOTFILES_DIR/$dotfile"
        target_file="$HOME/$dotfile"
        
        # Check if source file exists in project
        if [[ -f "$source_file" ]]; then
            create_symlink "$source_file" "$target_file"
        else
            log_warning "Dotfile .$dotfile not found in $DOTFILES_DIR, skipping..."
        fi
    done
    
    log_success "Dotfiles setup completed"
}

main() {
    log_info "Starting dotfiles setup..."
    
    setup_dotfiles
    
    log_success "🎉 Dotfiles setup completed!"
    log_info "All changes to dotfiles will now be git tracked in this repository"
    log_info "Dotfiles are stored in: $DOTFILES_DIR"
    log_info "Home directory dotfiles are symlinked to the project"
}

main "$@"