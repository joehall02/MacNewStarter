#!/opt/homebrew/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

if ! check_bash_version; then
    exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
DOTFILES_DIR="$PROJECT_ROOT/dotfiles"

setup_dotfiles() {
    log_info "Setting up dotfiles..."
    
    # Check if dotfile directory exists in project
    if [[ ! -d "$DOTFILES_DIR" ]]; then
        log_warning "Dotfile directory not found: $DOTFILES_DIR"
        exit 0
    fi
    
    # Iterate through dotfiles in dotfiles/
    shopt -s dotglob  # enable glob to match hidden files
    for dotfile in "$DOTFILES_DIR"/*; do
        source_file="$dotfile"
        target_file="$HOME/$(basename "$dotfile")"

        if [[ -f "$source_file" ]]; then
            create_dotfile_symlink "$source_file" "$target_file"
        else
            log_warning "Dotfile $(basename "$dotfile") not found in $DOTFILES_DIR, skipping..."
        fi
    done
    shopt -u dotglob  # restore default behavior
}

main() {
    # Confirm dotfiles setup
    if ! confirm_action "setting up dotfiles"; then
        exit 0
    fi
    
    log_info "Starting dotfiles setup..."

    if setup_dotfiles; then
        log_success "🎉 Dotfiles setup completed!"
        log_info "All changes to dotfiles will now be git tracked in this repository"
        log_info "Dotfiles are stored in: $DOTFILES_DIR"
        log_info "Home directory dotfiles are symlinked to the project"
    else 
        log_error "Dotfiles setup failed — missing or invalid directory."
    fi
}

main "$@"