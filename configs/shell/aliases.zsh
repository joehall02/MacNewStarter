# Return if the terminal is not interactive
[[ -o interactive ]] || return

# =========================================
# Aliases
# =========================================
# alias treeview='tree -C -a -L 3 --prune --noreport -I "node_modules|.git"'
alias size="du -h -s" # Show total size of a directory/file
alias restart-sketchybar="brew services restart sketchybar" # Restart sketchybar
alias mns="$MAC_NEW_STARTER_DIR/run.sh" # MacNewStarter CLI entrypoint
alias mns_dir="$MAC_NEW_STARTER_DIR"
alias lazygit='CONFIG_DIR="$HOME/.config/lazygit" lazygit'

