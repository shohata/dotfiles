# ----------------------------
# Paths
# ----------------------------
typeset -U path
typeset -U fpath

path=(
    "$HOME/.local/bin"(N-/)
    "$(brew --prefix)/opt/grep/libexec/gnubin"(N-/)
    "$(brew --prefix)/sbin"(N-/)
    "$path[@]"
)

fpath=(
    "$XDG_CONFIG_HOME/zsh/functions"(N-/)
    "$(brew --prefix)/share/zsh/site-functions"(N-/)
    "$fpath[@]"
)

# ----------------------------
# Reset key mappings
# ----------------------------
bindkey -d          # reset key bindings
bindkey -e          # use emacs key bindings
bindkey -r '^J'     # unbind Ctrl-j for tmux prefix

# ----------------------------
# Load functions
# ----------------------------
autoload -Uz load_aliases
autoload -Uz load_env
autoload -Uz load_history
autoload -Uz load_keymaps
autoload -Uz load_local
autoload -Uz load_options

# ----------------------------
# Plugins
# ----------------------------
ZINIT_HOME="$XDG_DATA_HOME/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "$ZINIT_HOME/zinit.zsh"

ZINIT[ZCOMPDUMP_PATH]="$XDG_CACHE_HOME/zsh/zcompdump"

PS1="%F{green}%1~"$'\n'"➜ %f"
zinit ice wait"0a" lucid
zinit light spaceship-prompt/spaceship-prompt

zinit ice wait"0b" lucid
zinit light momo-lab/zsh-replace-multiple-dots

zinit ice wait"0b" lucid
zinit light Aloxaf/fzf-tab

zinit ice wait"0c" lucid atload"load_keymaps"
zinit light yuki-yano/zeno.zsh

zinit ice wait"0d" lucid
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait"0d" lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit ice wait"0e" lucid blockf \
    atload"load_aliases; load_env; load_history; load_options; load_local; zicompinit; zicdreplay"
zinit light zsh-users/zsh-completions
