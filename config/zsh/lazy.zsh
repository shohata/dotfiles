#/usr/bin/env zsh

# ----------------------------
# History
# ----------------------------
HISTFILE="${XDG_STATE_HOME}/zsh_history"
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
# asdf
# ----------------------------
# Space expands abbreviations (abbr-expand-and-space)
# Ctrl+Space is a normal space
# Enter expands and accepts abbreviations (abbr-expand-and-accept)
if [[ -x "$(command -v asdf)" ]]; then
    if [[ -x "$(command -v brew)" ]]; then
        source "$(brew --prefix asdf)/libexec/asdf.sh"
    fi
fi

# ----------------------------
# Google Cloud SDk
# ----------------------------
if [[ -x "$(command -v gcloud)" ]]; then
    if [[ -x "$(command -v brew)" ]]; then
        source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
        source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
    fi
fi

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
zstyle ':completion::complete:*' cache-path "${XDG_CACHE_HOME}/zsh/zcompcache"

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
# Snippets
# ----------------------------
show_snippets() {
    local snippets=$(cat "${ZDOTDIR}/snippets" | fzf | cut -d':' -f2-)
    LBUFFER="${LBUFFER}${snippets}"
    zle reset-prompt
}
zle -N show_snippets
bindkey '^Y' show_snippets

# ----------------------------
# Aliases
# ----------------------------
# Helpers
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias rmf="rm -rf"

if [[ -x "$(command -v exa)" ]]; then
    alias ll="exa --icons --git --long"
    alias la="exa --icons --git --all"
    alias lla="exa --icons --git --long --all"
    alias lld="exa --icons --git --long | grep ^d"
else
    alias ll="ls -lh"
    alias la="ls -ah"
    alias lla="ls -alh"
    alias lld="ls -lh | grep ^d"
fi

# Disk free, in Gigabytes, not bytes
alias df="df -h"

# Calculate disk usage for a folder
alias du="du -h -c"

# ----------------------------
# Local zshrc
# ----------------------------
# If a ~/.zshrc.local exists, source it
[[ -f "${HOME}/.zshrc.local" ]] && source "${HOME}/.zshrc.local"
