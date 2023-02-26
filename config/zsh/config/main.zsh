# ----------------------------
# Paths
# ----------------------------
typeset -U path
typeset -U fpath

path=(
    /usr/local/opt/grep/libexec/gnubin(N-/)
    /usr/local/sbin(N-/)
    $HOME/.local/bin(N-/)
    $XDG_CONFIG_HOME/scripts(N-/)
    $path
)

fpath=(
    /usr/local/share/zsh/site-functions(N-/)
    $XDG_CONFIG_HOME/zsh/completions(N-/)
    $fpath
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
# Widgets
# ----------------------------
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

autoload -Uz edit-command-line
zle -N edit-command-line

# ----------------------------
# Key Mappings
# ----------------------------
bindkey -e                      # use emacs key bindings
bindkey "^O" edit-command-line  # edit the current command line in $EDITOR

# ----------------------------
# Completions
# ----------------------------
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zcompcache"

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
# Others
# ----------------------------
export REPORTTIME=10            # display how long all tasks over 10 seconds take
export KEYTIMEOUT=1             # 10ms delay for key sequences

# This is where my code exists and where I want the `c` autocomplete to work from exclusively
if [[ -d ~/code ]]; then
    export CODE_DIR=~/code
elif [[ -d ~/Developer ]]; then
    export CODE_DIR=~/Developer
fi

# If a ~/.zshrc.local exists, source it
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
