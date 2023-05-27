# ----------------------------
# Basic configurations
# ----------------------------
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR="nvim"
export GIT_EDITOR="nvim"

# ----------------------------
# XDG base directory
# ----------------------------
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# ----------------------------
# Zsh dot directory
# ----------------------------
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# ----------------------------
# dotfiles directory
# ----------------------------
export DOTFILES="$(dirname "$(dirname "$(dirname "$(readlink "${(%):-%N}")")")")"

# Skip the not really helping Ubuntu global compinit
skip_global_compinit=1
