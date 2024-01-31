#!/bin/zsh
# それぞれのファイルパス

declare -A config_path
config_path["nvim"]="$HOME/.config/nvim/init.lua"
config_path["tmux"]="$HOME/.tmux.conf"
config_path["zsh"]="$HOME/.zshrc"

declare -A source_path
source_path["nvim"]="vim.cmd('source $HOME/.dotfiles/nvim/init.lua')"
source_path["tmux"]="source-file '$HOME/.dotfiles/tmux/.tmux.conf'"
source_path["zsh"]="source '$HOME/.dotfiles/zsh/.zshrc'"

function path_setting_file() {
    for  Cpath in "${!config_path[@]}"; do
        echo "$Cpathの設定ファイルを生成します。"
        if ! mkdir -p "$(dirname "${config_path[$Cpath]}")"; then
            echo "ディレクトリの作成に失敗しました"
            return 1
        fi
        # ファイルにソースファイルを追記
        if ! echo "${source_path[$Cpath]}" >> "${config_path[$Cpath]}"; then
            echo "ファイルへの書き込みに失敗しました"
            return 1
        fi
    done
}

path_setting_file
