#/usr/bin/env zsh

# ----------------------------
# History
# ----------------------------
HISTFILE="$XDG_STATE_HOME/zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt EXTENDED_HISTORY         # write the history file in the ":start:elapsed;command" format.
setopt SHARE_HISTORY            # share history between all sessions.
setopt HIST_REDUCE_BLANKS       # remove superfluous blanks before recording entry.
setopt HIST_IGNORE_ALL_DUPS     # delete old recorded entry if new entry is a duplicate.

# exclude the commands like `cd` and `ls`
zshaddhistory() {
    local line="${1%%$'\n'}"
    [[ ! "$line" =~ "^(cd|history|jj?|lazygit|la|ll|ls|rm|rmdir|trash)($| )" ]]
}

# ----------------------------
# less
# ----------------------------
export LESSHISTFILE="$XDG_STATE_HOME/lesshst"

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
export SQLITE_HISTORY="$XDG_STATE_HOME/sqlite_history"
export MYSQL_HISTFILE="$XDG_STATE_HOME/mysql_history"
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"

# ----------------------------
# Node.js
# ----------------------------
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node_repl_history"

# ----------------------------
# npm
# ----------------------------
export NPM_CONFIG_DIR="$XDG_CONFIG_HOME/npm"
export NPM_DATA_DIR="$XDG_DATA_HOME/npm"
export NPM_CACHE_DIR="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_USERCONFIG="$NPM_CONFIG_DIR/npmrc"

# ----------------------------
# python
# ----------------------------
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"

# ----------------------------
# repgrep
# ----------------------------
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"

# ----------------------------
# zsh-abbr
# ----------------------------
export ABBR_AUTOLOAD=0
export ABBR_USER_ABBREVIATIONS_FILE="$XDG_CONFIG_HOME/zsh-abbr/user-abbreviations"

# ----------------------------
# fzf
# ----------------------------
if [ -f $HOME/.fzf.zsh ]; then
    export FZF_DEFAULT_COMMAND="fd --type f"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_DEFAULT_OPTS="--color bg:-1,bg+:-1,fg:-1,fg+:#feffff,hl:#993f84,hl+:#d256b5,info:#676767,prompt:#676767,pointer:#676767"
    source "$HOME/.fzf.zsh"
fi

# ----------------------------
# navi
# ----------------------------
if [[ -x "$(command -v navi)" ]]; then
    #export NAVI_PATH="$XDG_DATA_HOME/navi/cheats"
    export NAVI_PATH="$(navi info cheats-path)"
    export CHEATS_PATH="$XDG_CONFIG_HOME/navi/cheats"
    export NAVI_CONFIG="$XDG_CONFIG_HOME/navi/config.yaml"

    # Ctrl+G is assigned to launching navi
    eval "$(navi widget zsh)"
fi

# ----------------------------
# asdf
# ----------------------------
if [[ -x "$(command -v asdf)" ]]; then
    export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"
    export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME/asdf/asdfrc"

    # Space expands abbreviations (abbr-expand-and-space)
    # Ctrl+Space is a normal space
    # Enter expands and accepts abbreviations (abbr-expand-and-accept)
    source "$(brew --prefix asdf)/libexec/asdf.sh"
fi

# ----------------------------
# User
# ----------------------------
export KEYTIMEOUT=1                 # 10ms delay for key sequences
export CODE_DIR="$HOME/Developer"   # directory where my code exists
export THEME_FLAVOUR="mocha"        # catppuccin flavour

# ----------------------------
# Options
# ----------------------------
setopt COMPLETE_ALIASES     # make alias completion available
setopt NO_BG_NICE           # don't slow down background jobs
setopt NO_HUP               # don't kill background jobs when the shell exits
setopt NO_LIST_BEEP         # don't beep on completion
setopt PROMPT_SUBST         # Perform various expansions with prompt string

unsetopt LOCAL_OPTIONS      # If this option is set, all options are reverted when the shell function exits.
unsetopt LOCAL_TRAPS        # If this option is set, the trap is resoroted when the shell function exits.

# ----------------------------
# zstyle
# ----------------------------
# use caching to make completion for commands such as dpkg and apt usable.
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# default to file completion
zstyle ':completion:*' completer _expand _complete _files _correct _approximate

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# ----------------------------
# Aliases
# ----------------------------
# Helpers
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias rmf="rm -rf"
# Disk free, in Gigabytes, not bytes
alias df="df -h"
# Calculate disk usage for a folder
alias du="du -h -c"

# ----------------------------
# Local zshrc
# ----------------------------
# If a ~/.zshrc.local exists, source it
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
