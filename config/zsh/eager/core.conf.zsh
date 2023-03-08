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
# User configurations
# ----------------------------
export DOTFILES="$(dirname "$(dirname "$(readlink "$(dirname "$(dirname $0)")")")")"

# If a ~/.zshrc.local exists, source it
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
