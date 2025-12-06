# =========================================
# Start Zap (plugin manager)
# =========================================
ZAP_DIR="$HOME/.local/share/zap"
[ -f "$ZAP_DIR/zap.zsh" ] && source "$ZAP_DIR/zap.zsh"

# =========================================
# Load Zap plugins
# =========================================
plug "zap-zsh/supercharge"
plug "wintermi/zsh-lsd"
# plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-completions"
plug "wintermi/zsh-brew"
plug "atoftegaard-git/zsh-omz-autocomplete"

# =========================================
# Environment variables
# =========================================
if [ -f "$HOME/.env" ]; then
  source "$HOME/.env"
fi

if [ -f "$HOME/.config/shell/env.zsh" ]; then
  source "$ENV_FILE"
fi

# =========================================
# Initialise completion system
# =========================================
autoload -Uz compinit
zmodload zsh/complist

# Use menu completion (needed for Shift-Tab)
# setopt menucomplete

# Bind Tab and Shift-Tab
# bindkey '^I' expand-or-complete
bindkey '^[[Z' reverse-menu-complete
compinit -d "${ZDOTDIR:-$HOME}/.zcompdump"

# =========================================
# Add Homebrew and local completions to fpath
# This allows most CLI tools to provide tab completion automatically
# =========================================
fpath=(
  $(brew --prefix)/share/zsh/site-functions
  $fpath
)

# =========================================
# Enable Docker CLI completions.
# =========================================
fpath=(/$HOME/.docker/completions $fpath)

# =========================================
# Aliases
# =========================================
# alias treeview='tree -C -a -L 3 --prune --noreport -I "node_modules|.git"'

# =========================================
# NVM (Node Version Manager) setup
# =========================================
export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh"

# Enable nvm tab completion
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && . "$(brew --prefix nvm)/etc/bash_completion.d/nvm"

# =========================================
# FZF setup
# =========================================
source <(fzf --zsh)

# =========================================
# Starship Prompt
# =========================================
eval "$(starship init zsh)"

# =========================================
# LM Studio setup
# =========================================
export PATH="$PATH:/$HOME/.lmstudio/bin"