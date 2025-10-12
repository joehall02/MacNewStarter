# =========================================
# Start Zap (plugin manager)
# =========================================
ZAP_DIR="$HOME/.local/share/zap"
[ -f "$ZAP_DIR/zap.zsh" ] && source "$ZAP_DIR/zap.zsh"

# =========================================
# Initialize completion system
# =========================================
autoload -Uz compinit
compinit

# =========================================
# Add Homebrew and local completions to fpath
# This allows most CLI tools to provide tab completion automatically
# =========================================
fpath=(
  $(brew --prefix)/share/zsh/site-functions
  $fpath
)

# =========================================
# Load Zap plugins
# =========================================
plug "zap-zsh/supercharge"
# plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-completions"

# =========================================
# Aliases
# =========================================
alias treeview='tree -C -a -L 3 --prune --noreport -I "node_modules|.git"'

# =========================================
# NVM (Node Version Manager) setup
# =========================================
export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh"

# Enable nvm tab completion
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && . "$(brew --prefix nvm)/etc/bash_completion.d/nvm"

# =========================================
# Starship Prompt
# =========================================
eval "$(starship init zsh)"