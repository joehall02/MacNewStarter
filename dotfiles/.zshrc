# =========================================
# Environment variables
# =========================================
if [ -f "$HOME/.env" ]; then
  source "$HOME/.env"
fi

if [ -f "$HOME/.config/shell/env.zsh" ]; then
  source "$HOME/.config/shell/env.zsh"
fi

# =========================================
# Source Aliases
# =========================================
if [ -f "$HOME/.config/shell/aliases.zsh" ]; then
  source "$HOME/.config/shell/aliases.zsh"
fi

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
