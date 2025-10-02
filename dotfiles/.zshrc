# =========================================
# Powerlevel10k Instant Prompt
# =========================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =========================================
# Start Zap (plugin manager)
# =========================================
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# =========================================
# Powerlevel10k Theme
# =========================================
source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme

# Load user-specific Powerlevel10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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
  /usr/local/share/zsh/site-functions
  $fpath
)

# =========================================
# Load Zap plugins
# =========================================
plug "zap-zsh/supercharge"
#plug "zap-zsh/zap-prompt"
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
# Oh-my-posh Prompt
# =========================================
# if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
#   # eval "$(oh-my-posh init zsh --config 'powerlevel10k_rainbow')"
#   eval "$(oh-my-posh init zsh --config '~/.oh-my-posh-theme.omp.json')"
# fi
