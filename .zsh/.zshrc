#==============================================================
#
# C O N F I G U R A T I O N  F O R  Z S H
#

#=-=-=-=-=-=-=
# load stuffs
#=-=-=-=-=-=-=

autoload -U colors && colors
autoload -U compinit && compinit
autoload -U vcs_info && vcs_info

zmodload zsh/complist
zmodload zsh/terminfo

# setopt
setopt \
  autocd \
  ksh_glob \
  extendedglob \
  prompt_subst \
  inc_append_history

bindkey -v

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# Import seperate config files
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

for r in $HOME/.zsh/*.zsh; do
  if [[ $DEBUG > 0 ]]; then
    echo "zsh: sourcing $r"
  fi
  source $r
done

#=-=-=-=-
# Paths
#=-=-=-=-

export PATH=$PATH:$HOME/.bin
export PATH=/usr/local/bin:$PATH

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/gocode
export GOBIN=$GOPATH/bin

export PATH=$PATH:$GOBIN

# added by travis gem
[ -f /home/paradox/.travis/travis.sh ] && source /home/paradox/.travis/travis.sh

# boot2docker
# export DOCKER_HOST=tcp://192.168.59.103:2376
# export DOCKER_CERT_PATH=/Users/jake.luer/.boot2docker/certs/boot2docker-vm
# export DOCKER_TLS_VERIFY=1

eval $(docker-machine env dev)
