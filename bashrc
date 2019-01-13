#!/bin/bash

# Inspired greatly by Armin Ronacher's bashrc
# https://github.com/mitsuhiko/dotfiles/blob/master/bash/bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

DEFAULT_COLOR="[00;1m"
GRAY_COLOR="[37;1m"
PINK_COLOR="[35;1m"
GREEN_COLOR="[32;1m"
CYAN_COLOR="[36;1m"
ORANGE_COLOR="[33;1m"
RED_COLOR="[31;1m"
if [ `id -u` == '0' ]; then
  USER_COLOR=$RED_COLOR
else
  USER_COLOR=$ORANGE_COLOR
fi

VCPROMPT_EXECUTABLE=/usr/local/bin/vcprompt
SSHUTTLE_EXECUTABLE=/usr/local/bin/sshuttle

function vcprompt() {
  if [ -e "$VCPROMPT_EXECUTABLE" ]; then
    $VCPROMPT_EXECUTABLE -f $' on \033[1;34m%n\033[00;1m:\033[0;37m%b\033[32;1m%m%u'
  fi
}

function lastcommandfailed() {
  code=$?
  if [ $code != 0 ]; then
    echo -n $'\033[37;1m exited \033[31;1m'
    echo -n $code
    echo -n $'\033[37;1m'
  fi
}

function backgroundjobs() {
  jobs|python -c 'if 1:
    import sys
    items = ["\033[36;1m%s\033[37;1m" % x.split()[2]
             for x in sys.stdin.read().splitlines()]
    if items:
      if len(items) > 2:
        string = "%s, and %s" % (", ".join(items[:-1]), items[-1])
      else:
        string = ", ".join(items)
      print("\033[37;1m running %s" % string)
  '
}

function activevirtualenv() {
  if [ -n "$VIRTUAL_ENV" ]; then
      echo -n $'\033[00;1m:\033[36;1m'
      echo -n "$(basename $VIRTUAL_ENV)"
  fi
}


function docker.clean_containers() {
	 docker rm $(docker ps -a | grep -v Up | grep -v CONTAINER | cut -f 1 -d ' ')
 }

function docker.clean_images() {
    docker rmi $(docker images | grep none | tr -s ' ' | cut -f 3 -d ' ')
}

source <(helm completion bash)

KUBE_PS1_NS_ENABLE=false
source "/home/pgranger/kube-ps1/kube-ps1.sh"
kubeoff # off by default

export BASEPROMPT='\n\e${USER_COLOR}\u\
`activevirtualenv`\
$(kube_ps1) \
\e${RED_COLOR}${AWS_DEFAULT_PROFILE} \
\e${GRAY_COLOR}in \e${GREEN_COLOR}\w\
\e${GRAY_COLOR}`vcprompt`\
`backgroundjobs`\
\e${DEFAULT_COLOR}'


export TERM=screen-256color

export CLICOLOR=1
alias ls='ls --color=auto'
export IGNOREEOF=1
export LESS=FRSX

export EDITOR=vim
export PYOPEN_CMD=subl
export GIT_EDITOR=$EDITOR

export LIBTOOLIZE=glibtoolize

export PATH=/usr/local/share/npm/bin:/usr/local/go/bin:~/.bin:/usr/local/bin:/usr/local/sbin:$HOME/Development/go/bin:/home/pgranger/.local/bin:$PATH

# python
export PYTHONDONTWRITEBYTECODE=1

# virtualenvwrapper and pip
if [ `id -u` != '0' ]; then
  export VIRTUAL_ENV_DISABLE_PROMPT=1
  export VIRTUALENV_USE_DISTRIBUTE=1
  export WORKON_HOME=$HOME/.virtualenvs
  export PIP_VIRTUALENV_BASE=$WORKON_HOME
  export PIP_REQUIRE_VIRTUALENV=true
  export PIP_RESPECT_VIRTUALENV=true
  export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
  if [ -e "/usr/local/bin/virtualenvwrapper.sh" ]; then
    source /usr/local/bin/virtualenvwrapper.sh
  fi
fi

# Enable bash history
export HISTCONTROL=erasedups
export HISTSIZE=5000
shopt -s histappend

export FALLBACK_DYLD_LIBRARY_PATH=/usr/local/lib

# we always pass these to ls(1)
LS_COMMON="-hBG"

# setup the main ls alias if we've established common args
test -n "$LS_COMMON" &&
alias ls="command ls $LS_COMMON"

# These set up/down to do the history searching
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

alias ..='cd ..'

alias edit='$EDITOR $@'

function cleanswp() {
  find . -name "*.swp" -exec rm -rf {} \;

}
function cleanpycs() {
  find . -name "*.pyc" -exec rm -rf {} \;
}

# This will remove all *.pyc files and __pycache__ directories recursively in the current directory.
function cleanpycache() {
  find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf
}

function tfree() {
  top -l1 -s0 | head -n11
}

if [ -e "$HOME/.local-bashrc" ]; then
  source "$HOME/.local-bashrc"
fi

# Use git-completion if available
if [ -e "$HOME/.git-completion.bash" ]; then
  source "$HOME/.git-completion.bash"
fi;

# Use bash-completion, if available
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

[[ -s ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm  # This loads RVM into a shell session.


export PROMPT="${BASEPROMPT}
$ "
export PS1=$PROMPT

function docker.clean_containers() {
    docker rm $(docker ps -a | grep -v Up | grep -v CONTAINER | cut -f 1 -d ' ')
}

function docker.clean_images() {
    docker rmi $(docker images | grep none | tr -s ' ' | cut -f 3 -d ' ')
}

function git.remove_untracked_remote_branch(){
    # fetch and prune remte
    # delete all local branch with no remote
    git fetch -p && git branch -vv | grep gone |gawk '{print $1}' | xargs git branch -d
}

function docker.clean_volumes(){
    docker volume rm $(docker volume ls -qf dangling=true)
}

function list_stashes(){
    # list stashes and if mounted or not
    echo -e "mounted\tstash"
    for STASH in $(gnome-encfs-manager list_stashes|gawk '{ print $1};')
    do
        local myres=$(gnome-encfs-manager is_mounted $STASH)
        echo -e "$myres\t$STASH"
    done
}

export GPG_TTY=$(tty)

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH=$PATH:/home/pgranger/bin

if [ $TILIX_ID ] || [ $VTE_VERSION ] ; then source /etc/profile.d/vte-2.91.sh; fi # Ubuntu Budgie END

function aws.profile {
    export AWS_DEFAULT_PROFILE=$1
}

KUBECONFIG=~/.kube/config
for filename in $(find ~/.kube/ -maxdepth 1 -type f); do
    if [[ ! "$filename" =~ "kubectx" ]]; then
        [[ "$KUBECONFIG" =~ "$filename" ]] || KUBECONFIG=$KUBECONFIG:$filename
    fi
done
export KUBECONFIG

eval "$(direnv hook bash)"

if [ -z "$VIRTUAL_ENV" ]; then
    export PATH="~/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

alias k=kubectl
alias kx=kubectx
alias vim=nvim.appimage
