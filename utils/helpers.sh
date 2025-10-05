#!/bin/bash

# Utility function for logging info
log_info() {
    echo "ℹ️ [INFO] $*"
}

# Utility function for logging success
log_success() {
    echo "✅ [SUCCESS] $*"
}

# Utility function for logging warnings
log_warning() {
    echo "⚠️ [WARNING] $*"
}

# Utility function for logging errors
log_error() {
    echo "🛑 [ERROR] $*"
}

# Utility function to ensure Homebrew CLI is available
check_brew_is_installed() {
    if ! command -v brew >/dev/null 2>&1; then
        log_error "Homebrew CLI ('brew') not found in PATH."
        return 1
    fi
}

# Utility function to ensure VSCode CLI is available
check_vs_code_is_installed() {
    if ! command -v code >/dev/null 2>&1; then
        log_error "VSCode CLI ('code') not found in PATH."
        return 1
    fi
}

# Utility function to confirm installation
confirm_action() {
    action="$1"

    read -p "Do you want to proceed with '$action'? [y/N]: " confirm
    # POSIX-compatible lowercasing
    confirm_lower=$(printf "%s" "$confirm" | tr '[:upper:]' '[:lower:]')

    if [[ "$confirm_lower" != "y" && "$confirm_lower" != "yes" ]]; then
        log_info "Skipping '$action'."
        return 1
    fi
}

# Utility function to install a package using Homebrew
install_via_brew() {
    package="$1"

    # Check if the package exists in Homebrew
    if ! brew info "$package" >/dev/null 2>&1; then
        log_warning "Package '$package' not found in Homebrew."
        return 0
    fi

    # Install package if not already installed
    if ! brew list -1 | grep -q "^$package\$"; then
        log_info "Installing $package..."
        brew install "$package"
    else
        log_info "$package is already installed."
    fi
}

# Utility function to install Homebrew GUI apps
install_brew_gui_app() {
    app="$1"

    # Check if the app exists in Homebrew
    if ! brew info "$app" >/dev/null 2>&1; then
        log_warning "App '$app' not found in Homebrew."
        return 0
    fi

    # Install app if not already installed
    if ! brew list --cask | grep -q "^$app\$"; then
        log_info "Installing $app..."
        brew install --cask "$app"
    else
        log_info "$app is already installed."
    fi
}

# Utility function to install VSCode extension
install_vscode_extension() {
    extension="$1"

    # Check if the extension is already installed
    if code --list-extensions | grep -q "^$extension$"; then
        log_info "VSCode extension '$extension' is already installed."
        return 0
    fi

    log_info "Installing VSCode extension '$extension'..."
    
    if ! code --install-extension "$extension"; then
        log_warning "VSCode extension '$extension' does not exist."
    fi
}

# Utility function to create a symlink
create_dotfile_symlink() {
    local source="$1"
    local target="$2"

    if [ -L "$target" ]; then
        # It's a symlink
        local current_target
        current_target=$(readlink "$target")
        if [[ "$current_target" == "$source" ]]; then
            log_info "Symlink for $target already points to $source, skipping."
            return 0
        else
            log_warning "Updating existing symlink: $target → $source"
            rm "$target"
        fi
    elif [ -e "$target" ]; then
        # It's a real file or directory
        local backup="${target}.backup_$(date +%Y%m%d%H%M%S)"
        log_warning "$target exists. Backing up to $backup"
        mv "$target" "$backup"
    fi

    log_info "Creating symlink from $source to $target..."
    if ln -s "$source" "$target"; then
        log_success "Symlink created: $target → $source"
    else
        log_error "Failed to create symlink for $target"
        return 0
    fi
}
