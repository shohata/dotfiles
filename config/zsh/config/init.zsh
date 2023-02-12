# ----------------------------
# Paths
# ----------------------------
typeset -U path
typeset -U fpath

path=(
    "/usr/local/opt/grep/libexec/gnubin"(N-/)
    "/usr/local/sbin"(N-/)
    "$HOME/.local/bin"(N-/)
    "$XDG_CONFIG_HOME/scripts"(N-/)
    "$path[@]"
)

fpath=(
    "/usr/local/share/zsh/site-functions"(N-/)
    "$XDG_CONFIG_HOME/zsh/completions"(N-/)
    "$fpath[@]"
)

# ----------------------------
# Options
# ----------------------------
setopt COMPLETE_ALIASES         # make alias completion available
setopt NO_BG_NICE
setopt NO_HUP                   # don't kill background jobs when the shell exits
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS
setopt LOCAL_TRAPS
setopt PROMPT_SUBST

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
export MANROFFOPT='-c'                                              # add color to man pages
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
# repgrep
# ----------------------------
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"

# ----------------------------
# navi
# ----------------------------
export NAVI_CONFIG="$XDG_CONFIG_HOME/navi/config.yaml"

# ----------------------------
# python
# ----------------------------
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"

# ----------------------------
# zeno.zsh
# ----------------------------
export ZENO_HOME="$XDG_CONFIG_HOME/zeno"
export ZENO_ENABLE_FZF_TMUX=1                   # if enable fzf-tmux
export ZENO_FZF_TMUX_OPTIONS='-p'               # if setting fzf-tmux options
export ZENO_ENABLE_SOCK=1                       # use UNIX domain socket
export ZENO_GIT_CAT='bat --color=always'        # git file preview with color
export ZENO_GIT_TREE='exa --tree'               # git folder preview with color

# ----------------------------
# SQL
# ----------------------------
export SQLITE_HISTORY="$XDG_STATE_HOME/sqlite_history"
export MYSQL_HISTFILE="$XDG_STATE_HOME/mysql_history"
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"

# ----------------------------
# Others
# ----------------------------
export REPORTTIME=10                            # display how long all tasks over 10 seconds take
export KEYTIMEOUT=1                             # 10ms delay for key sequences
export CODE_DIR="$HOME/Developer"               # directory where my code exists

# If a ~/.zshrc.local exists, source it
[[ -f ~/.zshrc.local ]] && source "$HOME/.zshrc.local"
