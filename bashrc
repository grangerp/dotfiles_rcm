#!/bin/bash
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export TERM=screen-256color

# shellcheck source=/dev/null
source <(helm completion bash)
# shellcheck source=/dev/null
source <(kubectl completion bash)

export EDITOR=vim
export PYOPEN_CMD=subl
export GIT_EDITOR=$EDITOR
export LIBTOOLIZE=glibtoolize
export PATH=/home/pgranger/go/bin:/usr/local/bin:/usr/local/sbin:/home/pgranger/.local/bin:/home/pgranger/bin:$PATH

# python
export PYTHONDONTWRITEBYTECODE=1

# Enable bash history
export HISTCONTROL=erasedups
export HISTSIZE=5000
shopt -s histappend

export FALLBACK_DYLD_LIBRARY_PATH=/usr/local/lib

# These set up/down to do the history searching
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

alias edit='$EDITOR $@'

if [ -e "$HOME/.local-bashrc" ]; then
  source "$HOME/.local-bashrc"
fi

# Use git-completion if available
if [ -e "/usr/share/bash-completion/completions/git" ]; then
  source "/usr/share/bash-completion/completions/git"
fi;

# Use bash-completion, if available
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

export GPG_TTY=$(tty)

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ "$TILIX_ID" ] || [ "$VTE_VERSION" ] ; then source /etc/profile.d/vte-2.91.sh; fi # Ubuntu Budgie END


KUBECONFIG=~/.kube/config
for filename in $(find ~/.kube/ -maxdepth 1 -type f); do
    if [[ ! "$filename" =~ "kubectx" ]]; then
        [[ "$KUBECONFIG" =~ "$filename" ]] || KUBECONFIG=$KUBECONFIG:$filename
    fi
done
export KUBECONFIG

eval "$(direnv hook bash)"

# asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

alias k="kubectl"
alias kx=kubectx
alias ke="k get events --sort-by .lastTimestamp"
alias vi=nvim.appimage
alias vim=nvim.appimage
alias pvpn="protonvpn-cli"
alias upgrade-all="sudo apt update && sudo apt upgrade && sudo snap refresh && flatpak upgrade && brew update && brew upgrade"

export PATH="$HOME/.poetry/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#kubectx and kubens
export PATH=~/.kubectx:$PATH

# tresorit-cli
export PATH=$PATH:/home/pgranger/.local/share/tresorit/

# invoke completion
source <(inv --print-completion-script bash)

export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
eval "$(starship init bash)"

export GO111MODULE=on
export GOPATH=$HOME/go
export GH_USERNAME=grangerp
