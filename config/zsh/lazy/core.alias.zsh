# reload zsh config
alias reload='RELOAD=1 source $ZDOTDIR/.zshrc'

# Helpers
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias df='df -h'                        # disk free, in Gigabytes, not bytes
alias du='du -h -c'                     # calculate disk usage for a folder

alias lpath='echo $PATH | tr ":" "\n"'  # list the PATH separated by new lines
alias la='ls -AF'
alias lld='ls -l | grep ^d'
alias rmf='rm -rf'

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop='defaults write com.apple.finder CreateDesktop -bool false && killall Finder'
alias showdesktop='defaults write com.apple.finder CreateDesktop -bool true && killall Finder'

# Recursively delete `.DS_Store` files
alias cleanup='find . -name "*.DS_Store" -type f -ls -delete'
# remove broken symlinks
alias clsym='find -L . -name . -o -type d -prune -o -type l -exec rm {} +'

# use exa if available
if [[ -x "$(command -v exa)" ]]; then
    alias l='exa --icons --git --all --long'
    alias ll='exa --icons --git --long'
else
    alias l='ls -lah'
    alias ll='ls -lFh'
fi
