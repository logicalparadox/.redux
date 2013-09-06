export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE=$HOME/.zsh/history
export DISPLAY=:0

export SHELL='/bin/zsh'
export EDITOR='vim'
export MANPAGER='vimpager'

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"

source ~/.nvm/nvm.sh
