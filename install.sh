#!/bin/sh

# ツールのインストールとアップデート
tools=('neovim' 'zsh' 'tmux' 'git' 'gh' 'fzf')
if [ "uname" == "Linux" ]; then
    sudo apt-get --yes install software-properties-common
    sudo apt update
    for tool in "${tools[@]}"; do
        sudo apt-get --yes install "$tool"
    done
elif [ "uname" == "Darwin" ]; then
    xcode-select --install
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install --cask docker
