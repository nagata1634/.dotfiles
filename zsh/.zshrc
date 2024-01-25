# Set up unicode
export LANG=ja_JP.UTF-8

# Environmental variables
source $HOME/.dotfiles/zsh/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=true

setopt PROMPT_SUBST

function git_color() {
  local git_info="$(__git_ps1 "%s")"
  if [[ $git_info == *"%"* ]] || [[ $git_info == *"*"* ]]; then
    echo '%F{red}'
  elif [[ $git_info == *"+"* ]]; then
    echo '%F{green}'
  else
    echo '%F{cyan}'
  fi
}
# Set PROMPT
setopt PROMPT_SUBST
PROMPT='$(git_color)$(__git_ps1)%F{cyan} →%f '
RPROMPT='%(?.%F{green}✔%f.%F{red}✘%f)'
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
if [ "$(uname -s)" = "Darwin" ]; then
  alias ls="ls -G"
  # source $HOME/.dotfiles/zsh/.zsh_alias_for_mac
else
  echo 'Mac OSではありません'
  # source $HOME/.dotfiles/zsh/.zsh_alias_for_GNU
fi

# SSHかどうかを判別
if [ -n "$SSH_CONNECTION" ]; then
  COPY_COMMAND="wshcopy"
else
  COPY_COMMAND="pbcopy"
fi

# Completion
source $HOME/.dotfiles/zsh/.zsh_completion

# Autostart tmux
if [ ! "$(tmux has-session -t 1 2>/dev/null)" ]; then
  tmux
else
  tmux attach-session
fi
# pyenv
if type pyenv > /dev/null 2>$1; then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi
