########################################################
# Configuration
########################################################
typeset -U path

# add functions
prepend_path /usr/local/opt/grep/libexec/gnubin
prepend_path /usr/local/sbin
prepend_path $DOTFILES/bin
prepend_path $HOME/bin

# define the code directory
# This is where my code exists and where I want the `c` autocomplete to work from exclusively
if [[ -d ~/code ]]; then
    export CODE_DIR=~/code
elif [[ -d ~/Developer ]]; then
    export CODE_DIR=~/Developer
fi

# display how long all tasks over 10 seconds take
export REPORTTIME=10
export KEYTIMEOUT=1              # 10ms delay for key sequences

setopt NO_BG_NICE
setopt NO_HUP                    # don't kill background jobs when the shell exits
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS
setopt LOCAL_TRAPS
setopt PROMPT_SUBST

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY          # write the history file in the ":start:elapsed;command" format.
setopt HIST_REDUCE_BLANKS        # remove superfluous blanks before recording entry.
setopt SHARE_HISTORY             # share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS      # delete old recorded entry if new entry is a duplicate.

# make alias completion available
setopt COMPLETE_ALIASES

# use emacs key bindings
bindkey -e

# edit the current command line in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "jj" vi-cmd-mode

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

########################################################
# Setup
########################################################

if [ -f $HOME/.fzf.zsh ]; then
  source $HOME/.fzf.zsh
  export FZF_DEFAULT_COMMAND='fd --type f'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS='--color bg:-1,bg+:-1,fg:-1,fg+:#feffff,hl:#993f84,hl+:#d256b5,info:#676767,prompt:#676767,pointer:#676767'
fi

# add color to man pages
export MANROFFOPT='-c'
export LESS_TERMCAP_mb="$(tput bold; tput setaf 2)"
export LESS_TERMCAP_md="$(tput bold; tput setaf 6)"
export LESS_TERMCAP_me="$(tput sgr0)"
export LESS_TERMCAP_so="$(tput bold; tput setaf 3; tput setab 4)"
export LESS_TERMCAP_se="$(tput rmso; tput sgr0)"
export LESS_TERMCAP_us="$(tput smul; tput bold; tput setaf 7)"
export LESS_TERMCAP_ue="$(tput rmul; tput sgr0)"
export LESS_TERMCAP_mr="$(tput rev)"
export LESS_TERMCAP_mh="$(tput dim)"

# source z.sh if it exists
zpath="$(brew --prefix)/etc/profile.d/z.sh"
if [ -f "$zpath" ]; then
    source "$zpath"
fi

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # macOS `ls`
    colorflag="-G"
fi

# If a ~/.zshrc.local exists, source it
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
# If a ~/.localrc zshrc exists, source it
[[ -a ~/.localrc ]] && source ~/.localrc
