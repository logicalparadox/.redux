# Sudo
alias s='sudo'

# Arch
alias yt='yaourt'

# CD
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'

# RM
alias rm='rm -r'
alias rmf='rm -rf'

# CP
alias cp='cp -r'
alias cpp='rsync -PrlpE'
alias cpz='rsync -PrlpEz'

# LS
if whence dircolors > /dev/null; then
  eval "$(dircolors -b)"
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  alias ls="ls --color"
else 
  export CLICOLOR=1
  zstyle ':completion:*:default' list-colors ''
fi

alias ll='ls -alh'

# MKDIR
alias mk='mkdir -p'
alias mkdir='mkdir -p'

# Various
alias cls='clear'
alias h='history'
alias wget='wget -c'

# Mounting
alias musb='sudo mount /dev/sdb'
alias uusb='sudo umount /mnt/usb'

# Tmux
alias irc='tmux -2 a -t irc'
alias imap='tmux -2 a -t imap'
alias t='tmux -2 a -t tmux'

# Ping
alias pr='ping -c 1 192.168.1.1 | tail -3'
alias pg='ping -c 1 google.com | tail -3'

# Fun with sed
alias df='df -h | grep sd |\
  sed -e "s_/dev/sda[1-9]_\x1b[34m&\x1b[0m_" |\
  sed -e "s_/dev/sd[b-z][1-9]_\x1b[33m&\x1b[0m_" |\
  sed -e "s_[,0-9]*[MG]_\x1b[36m&\x1b[0m_" |\
  sed -e "s_[0-9]*%_\x1b[32m&\x1b[0m_" |\
  sed -e "s_9[0-9]%_\x1b[31m&\x1b[0m_" |\
  sed -e "s_/mnt/[-_A-Za-z0-9]*_\x1b[34;1m&\x1b[0m_"'

alias duch='du -ch | grep insgesamt |\
  sed -e "s_[0-9]*,[0-9]*[B|G|K|M|T]_\x1b[32m&\x1b[0m_"'

# node.js harmony
# alias node='node --harmony --harmony_typeof'
alias sn='supernova'
alias fig='docker-compose'
