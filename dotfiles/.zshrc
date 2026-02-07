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
# NVM (Node Version Manager) setup
# =========================================
export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh"

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
