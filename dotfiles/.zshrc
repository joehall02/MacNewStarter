# =========================================
# Environment variables
# =========================================
[ -f "$HOME/.env" ] && source "$HOME/.env"

[ -f "$HOME/.config/shell/env.zsh" ] && source "$HOME/.config/shell/env.zsh"

# =========================================
# Source Aliases
# =========================================
[ -f "$HOME/.config/shell/aliases.zsh" ] && source "$HOME/.config/shell/aliases.zsh"

# export lazygit

# Default to primary setup
ZSH_MODE="${ZSH_MODE:-primary}"

# Options key cursor back and forth
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# =========================================
# FZF setup
# =========================================
if [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

if [ -f /usr/share/doc/fzf/examples/completion.zsh ]; then
    source /usr/share/doc/fzf/examples/completion.zsh
fi

case "$ZSH_MODE" in
  omz)
    source ~/.zshrc.ohmyzsh
    ;;
  primary)
    source ~/.zshrc.primary
    ;;
esac
