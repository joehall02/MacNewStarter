#!/usr/bin/env bash

# =========================================
# Loggers
# =========================================

# Utility function for logging info
log_info() {
    printf "\n"
    echo "ℹ️ [INFO] $*"
}

# Utility function for logging success
log_success() {
    printf "\n"
    echo "✅ [SUCCESS] $*"
}

# Utility function for logging warnings
log_warning() {
    printf "\n"
    echo "⚠️ [WARNING] $*"
}

# Utility function for logging errors
log_error() {
    printf "\n"
    echo "🛑 [ERROR] $*"
}

# =========================================
# Checkers
# =========================================

# Utility function to check for minimum bash version 4.0
check_bash_version() {
    local min_major=4
    local bash_major="${BASH_VERSINFO[0]:-0}"
    if [ "$bash_major" -lt "$min_major" ]; then
        log_error "This script requires bash version 4.0 or higher. Please install a newer bash (e.g., via Homebrew) and run with 'bash run.sh'." >&2
        return 1
    fi
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

# =========================================
# Installers
# =========================================

# Utility function to install everything declared in a Brewfile.
# Unlike a per-package loop, brew bundle resolves installed state once, batches
# the installs, and exits non-zero naming how many entries failed — so a stale
# or renamed entry surfaces as an error instead of a warning buried in the log.
install_via_brewfile() {
    local brewfile="$1"
    local label="$2"

    if [[ ! -f "$brewfile" ]]; then
        log_error "Brewfile not found: $brewfile"
        return 1
    fi

    log_info "Installing $label from $(basename "$brewfile")..."

    # --no-upgrade keeps a setup run from turning into a full upgrade of
    # everything already on the machine.
    if ! brew bundle install --file="$brewfile" --no-upgrade --verbose; then
        log_error "Some $label failed to install. See the brew bundle output above."
        return 1
    fi
}

# Utility function to report whether a Brewfile is fully satisfied.
# Installs nothing; returns non-zero when anything is missing.
check_via_brewfile() {
    local brewfile="$1"
    local label="$2"

    if [[ ! -f "$brewfile" ]]; then
        log_error "Brewfile not found: $brewfile"
        return 1
    fi

    # --no-upgrade matches install_via_brewfile, so this reports only what is
    # genuinely missing. Without it, check counts merely-outdated packages as
    # unmet and contradicts what the install commands would actually do.
    if brew bundle check --file="$brewfile" --no-upgrade --verbose; then
        log_success "$label: all entries installed."
    else
        log_warning "$label: missing entries listed above."
        return 1
    fi
}

# Utility function to install VSCode extensions
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

# =========================================
# Others
# =========================================

# Utility function to create a symlink
create_symlink() {
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

# Utility function to confirm installation
confirm_action() {
    action="$1"

    read -rp "Do you want to proceed with '$action'? [y/N]: " confirm
    # POSIX-compatible lowercasing
    confirm_lower=$(printf "%s" "$confirm" | tr '[:upper:]' '[:lower:]')

    if [[ "$confirm_lower" != "y" && "$confirm_lower" != "yes" ]]; then
        log_info "Skipping '$action'."
        return 1
    fi
}

setup_vscode_settings() {
    local settings_dir="$1"
    local home_settings_dir="$2"
    local app_name="$3"

    VSCODE_SETTINGS_DIR="$settings_dir"
    HOME_VSCODE_SETTINGS_DIR="$home_settings_dir"

    log_info "Setting up $app_name settings..."
    
    vscode_settings_symlink() {
        # Check if vscode settings directory exists in project
        if [[ ! -d "$VSCODE_SETTINGS_DIR" ]]; then
            log_warning "$app_name settings directory not found: $VSCODE_SETTINGS_DIR"
            return 1
        fi
        
        # Iterate through settings files in vscode/
        for settings_file in "$VSCODE_SETTINGS_DIR"/*; do
            source_file="$settings_file"
            target_file="$HOME_VSCODE_SETTINGS_DIR/$(basename "$settings_file")"

            if [[ -f "$source_file" ]]; then
                create_symlink "$source_file" "$target_file"
            else
                log_warning "Setting file $(basename "$settings_file") not found in $VSCODE_SETTINGS_DIR, skipping..."
            fi
        done
    }

    main() {
        if vscode_settings_symlink; then
            log_success "🎉 $app_name settings setup completed!"
            log_info "All changes to $app_name settings will now be git tracked in this repository"
            log_info "$app_name settings are stored in: $VSCODE_SETTINGS_DIR"
            log_info "Home directory $app_name settings are symlinked to the project"
        else 
            log_error "$app_name settings setup failed — missing or invalid directory."
            return 1
        fi
    }

    main "$@"
}
