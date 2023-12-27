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
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CACHE_HOME="${HOME}/.cache"

# ----------------------------
# Zsh dot directory
# ----------------------------
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# ----------------------------
# dotfiles directory
# ----------------------------
export DOTFILES="$(dirname "$(dirname "$(dirname "$(readlink "${(%):-%N}")")")")"

# ----------------------------
# less
# ----------------------------
export LESSHISTFILE="${XDG_STATE_HOME}/lesshst"

# ----------------------------
# man
# ----------------------------
export MANROFFOPT="-c"                                              # add color to man pages
export LESS_TERMCAP_mb="$(tput bold; tput setaf 2)"                 # begin blinking
export LESS_TERMCAP_md="$(tput bold; tput setaf 6)"                 # begin bold
export LESS_TERMCAP_me="$(tput sgr0)"                               # end mode
export LESS_TERMCAP_so="$(tput bold; tput setaf 3; tput setab 4)"   # begin standout-mode
export LESS_TERMCAP_se="$(tput rmso; tput sgr0)"                    # end standout-mode
export LESS_TERMCAP_us="$(tput smul; tput bold; tput setaf 7)"      # begin underline
export LESS_TERMCAP_ue="$(tput rmul; tput sgr0)"                    # end underline
export LESS_TERMCAP_mr="$(tput rev)"                                # begin reverse-mode
export LESS_TERMCAP_mh="$(tput dim)"                                # begin half-bright-mode

# ----------------------------
# SQL
# ----------------------------
export SQLITE_HISTORY="${XDG_STATE_HOME}/sqlite_history"
export MYSQL_HISTFILE="${XDG_STATE_HOME}/mysql_history"
export PSQL_HISTORY="${XDG_STATE_HOME}/psql_history"

# ----------------------------
# nodebrew
# ----------------------------
export NODEBREW_ROOT="${XDG_DATA_HOME}/nodebrew"

# ----------------------------
# Node.js
# ----------------------------
export NODE_REPL_HISTORY="${XDG_STATE_HOME}/node_repl_history"

# ----------------------------
# npm
# ----------------------------
export NPM_CONFIG_DIR="${XDG_CONFIG_HOME}/npm"
export NPM_DATA_DIR="${XDG_DATA_HOME}/npm"
export NPM_CACHE_DIR="${XDG_CACHE_HOME}/npm"
export NPM_CONFIG_USERCONFIG="$NPM_CONFIG_DIR/npmrc"

# ----------------------------
# python
# ----------------------------
export PYTHONPYCACHEPREFIX="${XDG_CACHE_HOME}/python"
export PYTHONUSERBASE="${XDG_DATA_HOME}/python"

# ----------------------------
# repgrep
# ----------------------------
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/config"

# ----------------------------
# zsh-abbr
# ----------------------------
export ABBR_AUTOLOAD=0
export ABBR_USER_ABBREVIATIONS_FILE="${XDG_CONFIG_HOME}/zsh-abbr/user-abbreviations"

# ----------------------------
# fzf
# ----------------------------
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_DEFAULT_OPTS="--color bg:-1,bg+:-1,fg:-1,fg+:#feffff,hl:#993f84,hl+:#d256b5,info:#676767,prompt:#676767,pointer:#676767"

# ----------------------------
# asdf
# ----------------------------
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"

# ----------------------------
# User
# ----------------------------
export KEYTIMEOUT=1                 # 10ms delay for key sequences
export CODE_DIR="${HOME}/Developer" # directory where my code exists
export THEME_FLAVOUR="mocha"        # catppuccin flavour
export USER_ID="$(id -u)"
export GROUP_ID="$(id -g)"
export USER_NAME="$(id -nu)"
export GROUP_NAME="$(id -ng)"

# Skip the not really helping Ubuntu global compinit
skip_global_compinit=1
