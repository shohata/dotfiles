# ----------------------------
# Reset key mappings
# ----------------------------
bindkey -d          # reset key bindings
bindkey -e          # use emacs key bindings
bindkey -r '^J'     # unbind Ctrl-j for tmux prefix

# ----------------------------
# Edit command line
# ----------------------------
autoload -Uz edit-command-line
zle -N edit-command-line

# edit the current command line in $EDITOR
bindkey '^O' edit-command-line

# ----------------------------
# zeno.zsh
# ----------------------------
bindkey ' ' zeno-auto-snippet
bindkey '^M' zeno-auto-snippet-and-accept-line
bindkey '^I' zeno-completion
bindkey '^R' zeno-history-selection
bindkey '^X' zeno-insert-snippet
bindkey '^G' zeno-ghq-cd
