# locale
export LANG="en_US.UTF-8"

# editor
export EDITOR='nvim'
export GIT_EDITOR='nvim'

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# vim
export VIM_TMP="$HOME/.vim-tmp"

# ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"

# dotfiles
export DOTFILES="$(dirname "$(dirname "$(readlink "${(%):-%N}")")")"
