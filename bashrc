#!/bin/bash

# Inspired greatly by Armin Ronacher's bashrc

# https://github.com/mitsuhiko/dotfiles/blob/master/bash/bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export DEFAULT_COLOR="[00;1m"
export GRAY_COLOR="[37;1m"
export PINK_COLOR="[35;1m"
export GREEN_COLOR="[32;1m"
export CYAN_COLOR="[36;1m"
ORANGE_COLOR="[33;1m"
RED_COLOR="[31;1m"
if [ "$(id -u)" == '0' ]; then
  USER_COLOR=$RED_COLOR
else
  export USER_COLOR=$ORANGE_COLOR
fi

VCPROMPT_EXECUTABLE=~/bin/vcprompt
export SSHUTTLE_EXECUTABLE=/usr/local/bin/sshuttle

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


function activevirtualenv() {
  if [ -n "$VIRTUAL_ENV" ]; then
      echo -n $'\033[00;1m:\033[36;1m'
      echo -n "$(basename "$VIRTUAL_ENV")"
  fi
}

function docker.clean_containers() {
	 docker rm "$(docker ps -a | grep -v Up | grep -v CONTAINER | cut -f 1 -d ' ')"
 }

function docker.clean_images() {
    docker rmi "$(docker images | grep none | tr -s ' ' | cut -f 3 -d ' ')"
}

# shellcheck source=/dev/null
source <(helm completion bash)
# shellcheck source=/dev/null
source <(kubectl completion bash)

KUBE_PS1_NS_ENABLE=false
#source "/home/pgranger/kube-ps1/kube-ps1.sh"
source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
kubeoff "$@" # off by default

# shellcheck disable=SC2016,SC1004
BASEPROMPT='\n\e${USER_COLOR}\u\
$(activevirtualenv)\
$(kube_ps1) \
\e${RED_COLOR}${AWS_DEFAULT_PROFILE} \
\e${GRAY_COLOR}in \e${GREEN_COLOR}\w\
\e${GRAY_COLOR}$(vcprompt)\
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

export PATH=/home/pgranger/go/bin:/usr/local/bin:/usr/local/sbin:/home/pgranger/.local/bin:$PATH

# python
export PYTHONDONTWRITEBYTECODE=1

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

if [ -e "$HOME/.local-bashrc" ]; then
  source "$HOME/.local-bashrc"
fi

# Use git-completion if available
if [ -e "/usr/share/bash-completion/completions/git" ]; then
  source "/usr/share/bash-completion/completions/git"
fi;
if [ -e "~/.git-completion.bash" ]; then
  source "~/.git-completion.bash"
fi;

# Use bash-completion, if available
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

export PROMPT="${BASEPROMPT}
$ "
export PS1=$PROMPT

function git.remove_untracked_remote_branch(){
    # fetch and prune remote
    # delete all local branch with no remote
    git fetch -p && git branch -vv | grep gone |gawk '{print $1}' | xargs git branch -d
}

export GPG_TTY=$(tty)

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ "$TILIX_ID" ] || [ "$VTE_VERSION" ] ; then source /etc/profile.d/vte-2.91.sh; fi # Ubuntu Budgie END

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

alias k="kubectl"
alias kx=kubectx
alias ke="k get events --sort-by .lastTimestamp"
#alias vi=nvim.appimage
#alias vim=nvim.appimage
alias sq="cd ~/w/process-deployment-operator; ~/Downloads/sonar-scanner-4.2.0.1873-linux/bin/sonar-scanner -Dsonar.projectKey=pdd  -Dsonar.sources=. -Dsonar.host.url=http://localhost:9000  -Dsonar.login=3cb6f826242631230b885ab302d66b04023256eb -Dsonar.go.coverage.reportPaths=cover.out"
alias pvpn="protonvpn-cli"


export PATH="$HOME/.poetry/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#kubectx and kubens
export PATH=~/.kubectx:$PATH
export PATH=$PATH:/home/pgranger/.local/share/tresorit/

# invoke completion
source <(inv --print-completion-script bash)

export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

#. $HOME/.asdf/asdf.sh
. /usr/local/opt/asdf/asdf.sh

. /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash
#. $HOME/.asdf/completions/asdf.bash

# Created by `userpath` on 2021-01-22 20:45:37
export PATH="$PATH:/Users/philippe.granger/.local/bin"
