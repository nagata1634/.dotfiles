# Set up unicode
export LANG=ja_JP.UTF-8

# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

# Use color ls
if [ "$(uname -s)"=="Darwin" ]; then
  alias ls="ls -G"
  # source $HOME/.dotfiles/zsh/.zsh_alias_for_mac
else
  echo 'Mac OSではありません'
  # source $HOME/.dotfiles/zsh/.zsh_alias_for_GNU
fi

# prompt
source $HOME/.dotfiles/zsh/.zsh_completion

# pyenv PATH
if [ -e "PYTNV_PATH" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# Autostart tmux
if [ ! "$(tmux has-session -t 1 2>/dev/null)" ]; then
  tmux
else
  tmux attach-session
fi
# Environmental variables
export TMUX_HOSTNAME="$(hostname -s)"
