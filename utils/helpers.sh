#!/bin/bash

# Utility function to install a package using Homebrew
install_via_brew() {
    package="$1"

    # Check if the package exists in Homebrew
    if ! brew info "$package" >/dev/null 2>&1; then
        echo "Package '$package' not found in Homebrew."
        return 1
    fi

    if ! brew list -1 | grep -q "^$package1\$"; then
        echo "Installing $package..."
        brew install "$package"
    else
        echo "$package is already installed."
    fi
}

# Utility function to create a symlink
create_symlink() {
    local source="$1"
    local target="$2"
    
    if [ -e "$target" ]; then
        echo "$target already exists. Skipping symlink creation."
    else
        echo "Creating symlink from $source to $target..."
        ln -s "$source" "$target"
    fi
}

# Utility function for logging info
log_info() {
    echo -e "[INFO] $*"
}

# Utility function for logging success
log_success() {
    echo -e "\e[32m[SUCCESS]\e[0m $*"
}

# Utility function for logging warnings
log_warning() {
    echo -e "\e[33m[WARNING]\e[0m $*"
}