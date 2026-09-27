#!/opt/homebrew/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

if ! check_bash_version; then
    exit 0
fi

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
LISTS_DIR="$SCRIPT_DIR/../lists"

# Check brew is installed
if ! check_brew_is_installed; then
    exit 1
fi

# Read-only: reports what is missing without installing anything.
log_info "Checking Brewfiles against what is installed..."

status=0
check_via_brewfile "$LISTS_DIR/Brewfile.cli" "CLI tools" || status=1
check_via_brewfile "$LISTS_DIR/Brewfile.packages" "Extra packages" || status=1
check_via_brewfile "$LISTS_DIR/Brewfile.gui" "GUI applications" || status=1

if [[ "$status" -eq 0 ]]; then
    log_success "🎉 Everything in the Brewfiles is installed."
else
    log_warning "Some entries are missing. Run 'mns all' or an individual install command."
fi

exit "$status"
