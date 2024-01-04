#!/usr/bin/env bash

DOTFILES="$(pwd)"
COLOR_GRAY="\033[1;38;5;243m"
COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_PURPLE="\033[1;35m"
COLOR_YELLOW="\033[1;33m"
COLOR_NONE="\033[0m"

title() {
    echo -e "\n${COLOR_PURPLE}$1${COLOR_NONE}"
    echo -e "${COLOR_GRAY}==============================${COLOR_NONE}\n"
}

error() {
    echo -e "${COLOR_RED}Error: ${COLOR_NONE}$1"
    exit 1
}

warning() {
    echo -e "${COLOR_YELLOW}Warning: ${COLOR_NONE}$1"
}

info() {
    echo -e "${COLOR_BLUE}Info: ${COLOR_NONE}$1"
}

success() {
    echo -e "${COLOR_GREEN}$1${COLOR_NONE}"
}

create_symlink() {
    src="$1"
    dest="$2"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        answer="n"
        info "~${dest#$HOME} already exists..."
        read -p "Are you sure you want to overwrite? (Y/n): " answer
        case "$answer" in
        "" | "Y" | "y" | "Yes" | "yes")
            if [ -L "$dest" ]; then
                unlink "$dest"
            else
                rm -rf "$dest"
            fi
            info "Creating symlink for $src"
            ln -s "$src" "$dest"
            ;;
        esac
    else
        info "Creating symlink for $src"
        ln -s "$src" "$dest"
    fi
}

backup() {
    BACKUP_DIR="$HOME/dotfiles-backup"

    echo "Creating backup directory at $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"

    zshenv="$HOME/.zshenv"
    if [ -f "$zshenv" ]; then
        echo "backing up $zshenv"
        cp "$zshenv" "$BACKUP_DIR"
    else
        warning "$zshenv does not exist at this location or is a symlink"
    fi

    configs=$(find "$DOTFILES/config" -maxdepth 1 2>/dev/null)
    for config in $configs; do
        if [ ! -d "$config" ]; then
            echo "backing up $config"
            cp -rf "$cofig" "$BACKUP_DIR"
        else
            warning "$config does not exist at this location or is a symlink"
        fi
    done
}

setup_symlinks() {
    title "Creating symlinks"

    info "installing to ~/.zshenv"
    create_symlink "$DOTFILES/config/zsh/.zshenv" "$HOME/.zshenv"

    info "installing to ~/.local"
    if [ ! -d "$HOME/.local" ]; then
        info "Creating ~/.local"
        mkdir -p "$HOME/.local"
    fi
    create_symlink "$DOTFILES/bin" "$HOME/.local/bin"

    info "installing to ~/.config"
    if [ ! -d "$HOME/.config" ]; then
        info "Creating ~/.config"
        mkdir -p "$HOME/.config"
    fi

    configs=$(find "$DOTFILES/config" -mindepth 1 -maxdepth 1 -type d 2>/dev/null)
    for config in $configs; do
        create_symlink "$config" "$HOME/.config/$(basename "$config")"
    done
}

setup_homebrew() {
    title "Setting up Homebrew"

    if test ! "$(command -v brew)"; then
        info "Homebrew not installed. Installing."
        # Run as a login shell (non-interactive) so that the script doesn't pause for user input
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash --login
    fi

    if [ "$(uname)" == "Linux" ]; then
        test -d "$HOME/.linuxbrew" && eval "$($HOME/.linuxbrew/bin/brew shellenv)"
        test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        test -r "$HOME/.bash_profile" && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>"$HOME/.bash_profile"
    fi

    # install brew dependencies from Brewfile
    brew bundle
}

setup_nodebrew() {
    title "Configuring Nodebrew"

    info "Setting up nodebrew"
    nodebrew setup

    info "Installing latest Node.js"
    nodebrew install latest
    nodebrew use latest
}

setup_lima() {
    title "Configuring Lima"

    info "Installing Docker VM"
    limactl start template://docker

    info "Installing Docker CLI Plugins"
    pluginDir="$HOME/.docker/cli-plugins"
    mkdir -p $pluginDir
    ln -sfn "$(brew --prefix docker-compose)/bin/docker-buildx" "$pluginDir/compose"
    ln -sfn "$(brew --prefix docker-buildx)/bin/docker-buildx" "$pluginDir/docker-buildx"
}

setup_git() {
    title "Setting up Git"

    gitConfig="$HOME/.gitconfig.local"
    defaultName=$(git config user.name)
    defaultEmail=$(git config user.email)
    defaultGithub=$(git config github.user)

    read -rp "Name [$defaultName] " name
    read -rp "Email [$defaultEmail] " email
    read -rp "Github username [$defaultGithub] " github

    git config -f $gitConfig user.name "${name:-$defaultName}"
    git config -f $gitConfig user.email "${email:-$defaultEmail}"
    git config -f $gitConfig github.user "${github:-$defaultGithub}"

    if [[ "$(uname)" == "Darwin" ]]; then
        git config --global credential.helper "osxkeychain"
    else
        read -rn 1 -p "Save user and password to an unencrypted file to avoid writing? [y/N] " save
        if [[ $save =~ ^([Yy])$ ]]; then
            git config --global credential.helper "store"
        else
            git config --global credential.helper "cache --timeout 3600"
        fi
    fi
}

setup_shell() {
    title "Configuring shell"

    [[ -n "$(command -v brew)" ]] && zsh_path="$(brew --prefix)/bin/zsh" || zsh_path="$(which zsh)"
    if ! grep "$zsh_path" /etc/shells; then
        info "adding $zsh_path to /etc/shells"
        echo "$zsh_path" | sudo tee -a /etc/shells
    fi

    if [[ "$SHELL" != "$zsh_path" ]]; then
        chsh -s "$zsh_path"
        info "default shell changed to $zsh_path"
    fi
}

setup_terminfo() {
    title "Configuring terminfo"

    info "adding tmux.terminfo"
    tic -x "$DOTFILES/resources/tmux.terminfo"

    info "adding xterm-256color-italic.terminfo"
    tic -x "$DOTFILES/resources/xterm-256color-italic.terminfo"
}

setup_macos() {
    title "Configuring macOS"
    if [[ "$(uname)" == "Darwin" ]]; then

        info "====Global===="

        info "Only use UTF-8 in Terminal.app"
        defaults write com.apple.terminal StringEncodings -array 4

        info "Expand save dialog by default"
        defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

        info "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
        defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

        info "Enable subpixel font rendering on non-Apple LCDs"
        defaults write NSGlobalDomain AppleFontSmoothing -int 2

        info "Disable press-and-hold for keys in favor of key repeat"
        defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

        info "Set a blazingly fast keyboard repeat rate"
        defaults write NSGlobalDomain KeyRepeat -int 2

        info "Set a shorter Delay until key repeat"
        defaults write NSGlobalDomain InitialKeyRepeat -int 15

        info "====System===="

        info "Disable to create a new folder named .DS_Store"
        defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

        info "====Menubar===="

        info "Show percentage of batter"
        defaults write com.apple.menuextra.battery ShowPercent -string "YES"

        info "Change date format"
        defaults write com.apple.menuextra.clock DateFormat -string "M\u6708d\u65e5(EEE)  H:mm:ss"

        info "====Finder===="

        info "Set big icons on sidebar"
        defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 3

        info "Finder: show all filename extensions"
        defaults write NSGlobalDomain AppleShowAllExtensions -bool true

        info "Show hidden files by default"
        defaults write com.apple.Finder AppleShowAllFiles -bool false

        info "Show path bar in Finder"
        defaults write com.apple.finder ShowPathbar -bool true

        info "Show status bar in Finder"
        defaults write com.apple.finder ShowStatusBar -bool true

        info "Use current directory as default search scope in Finder"
        defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

        info "Show the ~/Library folder in Finder"
        chflags nohidden ~/Library

        info "====Dock===="

        info "Enable to expand tile on Dock (magnification)"
        defaults write com.apple.dock magnification -bool yes

        info "Set general tile size on Dock as 32"
        defaults write com.apple.dock tilesize -int 32

        info "Set expanded tile size on Dock as 128"
        defaults write com.apple.dock largesize -int 128

        info "Enable to hide and show Dock automatically"
        defaults write com.apple.dock autohide -bool true

        info "Enable to hide and show Dock immediately"
        defaults write com.apple.dock autohide-delay -float 0.0

        info "Enable quick hide animation of Dock"
        defaults write com.apple.dock autohide-time-modifier -float 1.0

        #info "Enable tap to click (Trackpad)"
        #defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

        #info "Enable Safari’s debug menu"
        #defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

        info "Kill affected applications"

        for app in Safari Finder Dock Mail SystemUIServer; do killall "$app" >/dev/null 2>&1; done
    else
        warning "macOS not detected. Skipping."
    fi
}

setup_hammerspoon() {
    title "Configuring Hammerspoon"
    if [[ "$(uname)" == "Darwin" ]]; then
        info "Set Hammerspoon config file directory as XDG Base Directory"
        defaults write org.hammerspoon.Hammerspoon MJConfigFile "$HOME/.config/hammerspoon/init.lua"
    else
        warning "macOS not detected. Skipping."
    fi
}

fetch_catppuccin_theme() {
    for palette in frappe latte macchiato mocha; do
        curl -o "$DOTFILES/config/kitty/themes/catppuccin-$palette.conf" "https://raw.githubusercontent.com/catppuccin/kitty/main/themes/$palette.conf"
    done
}

case "$1" in
backup)
    backup
    ;;
link)
    setup_symlinks
    ;;
homebrew)
    setup_homebrew
    ;;
nodebrew)
    setup_nodebrew
    ;;
lima)
    setup_lima
    ;;
git)
    setup_git
    ;;
shell)
    setup_shell
    ;;
terminfo)
    setup_terminfo
    ;;
macos)
    setup_macos
    ;;
hammerspoon)
    setup_hammerspoon
    ;;
catppuccin)
    fetch_catppuccin_theme
    ;;
all)
    setup_symlinks
    setup_homebrew
    setup_nodebrew
    setup_git
    setup_shell
    setup_terminfo
    ;;
*)
    echo -e $"\nUsage: $(basename "$0") {backup|link|homebrew|nodebrew|lima|git|shell|terminfo|macos|all}\n"
    exit 1
    ;;
esac

echo -e
success "Done."
