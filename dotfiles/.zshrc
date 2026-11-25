# =========================================
# Environment variables
# =========================================
[ -f "$HOME/.env" ] && source "$HOME/.env"

[ -f "$HOME/.config/shell/env.zsh" ] && source "$HOME/.config/shell/env.zsh"

# =========================================
# Source Aliases
# =========================================
[ -f "$HOME/.config/shell/aliases.zsh" ] && source "$HOME/.config/shell/aliases.zsh"

# =========================================
# LM Studio setup
# =========================================
export PATH="$PATH:/$HOME/.lmstudio/bin"

# =========================================
# Editor
# =========================================
export EDITOR=nvim

# =========================================
# SOPS - Tell sops where the age key is (macOS looks elsewhere by default)
# =========================================
export SOPS_AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt"

# =========================================
# NVM (Node Version Manager) setup
# =========================================
export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh"

# =========================================
# The login Keychain is locked in SSH sessions
# =========================================
if [[ -n "$SSH_CONNECTION" ]] && ! security show-keychain-info ~/Library/Keychains/login.keychain-db &>/dev/null; then
  security unlock-keychain ~/Library/Keychains/login.keychain-db
fi

export lazygit

# Default to primary setup
ZSH_MODE="${ZSH_MODE:-primary}"

case "$ZSH_MODE" in
  omz)
    source ~/.zshrc.ohmyzsh
    ;;
  primary)
    source ~/.zshrc.primary
    ;;
esac
