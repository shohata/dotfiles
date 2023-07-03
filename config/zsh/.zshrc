# ----------------------------
# Paths
# ----------------------------
typeset -U path
typeset -U fpath

path=(
    "${HOME}/.local/bin"(N-/)
    "$(brew --prefix grep)/libexec/gnubin"(N-/)
    "$(brew --prefix)/sbin"(N-/)
    "$path[@]"
)

fpath=(
    "$(brew --prefix)/share/zsh/site-functions"(N-/)
    "$fpath[@]"
)

# ----------------------------
# Load functions
# ----------------------------
autoload -Uz edit-command-line
zle -N edit-command-line

# ----------------------------
# Reset key mappings
# ----------------------------
bindkey -d                      # reset key bindings
bindkey -e                      # use emacs key bindings
bindkey -r '^J'                 # unbind Ctrl-j for tmux prefix
bindkey '^O' edit-command-line  # edit the current command line in $EDITOR

# ----------------------------
# Prompt
# ----------------------------
PS1="%F{green}%1~"$'\n'"❯%f "

# ----------------------------
# Plugins
# ----------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "${ZINIT_HOME}" ] && mkdir -p "$(dirname "${ZINIT_HOME}")"
[ ! -d "${ZINIT_HOME}/.git" ] && git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"

declare -A ZINIT
ZINIT[BIN_DIR]="${ZINIT_HOME}"
ZINIT[ZCOMPDUMP_PATH]="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/.zcompdump"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice wait"0a" lucid as"program" from"gh-r" \
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" \
    src"init.zsh"
zinit light starship/starship

zinit ice wait"0b" lucid \
    atclone"./install --xdg --key-bindings --completion --no-update-rc --no-bash --no-fish" \
    atpull"%atclone" \
    src"${XDG_CONFIG_HOME:-${HOME}/.config}/fzf/fzf.zsh"
zinit light junegunn/fzf

zinit ice wait"0b" lucid as"program" from"gh-r"
zinit light denisidoro/navi

zinit ice wait"0c" lucid
zinit light momo-lab/zsh-replace-multiple-dots

zinit ice wait"0c" lucid
zinit light Aloxaf/fzf-tab

zinit ice wait"0c" lucid
zinit light olets/zsh-abbr

zinit ice wait"0c" lucid
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait"0c" lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit ice wait"0d" lucid blockf \
    atload"source '${ZDOTDIR}/lazy.zsh'; zicompinit; zicdreplay"
zinit light zsh-users/zsh-completions
