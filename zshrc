# Uncomment to profile
# zmodload zsh/zprof

export PATH=$HOME/bin:$HOME/go/bin:$PATH

eval "$(/opt/homebrew/bin/brew shellenv)"

# to speedup ohmyzsh start time
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_AUTO_UPDATE="true"
DISABLE_COMPFIX="true"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

plugins=(git direnv kubectl kubectx)

source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"

ssh-add --apple-use-keychain ~/.ssh/id_ed25519
alias vim=nvim
alias vi=nvim
alias tldrf='tldr --list|fzf --preview "tldr {1} --color=always" --preview-window=right,70%|xargs tldr'

alias kx=kubectx
alias kns=kubectx


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export GOPRIVATE=github.com/metriodev/*
# to fix sqlc after upgrading mac os
# fix the error:
# # github.com/pganalyze/pg_query_go/v5/parser
# src_port_snprintf.c:374:1: error: static declaration of 'strchrnul' follows non-static declaration
# /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_string.h:198:9: note: previous declaration is here
# src_port_snprintf.c:438:27: warning: 'strchrnul' is only available on macOS 15.4 or newer [-Wunguarded-availability-new]
# /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_string.h:198:9: note: 'strchrnul' has been marked as being introduced in macOS 15.4 here, but the deployment target is macOS 15.0.0
# src_port_snprintf.c:438:27: note: enclose 'strchrnul' in a __builtin_available check to silence this warning
# db/generate.go:3: running "go": exit status 1
# make: *** [gen-sqlc] Error 1
export CGO_CFLAGS="-DHAVE_STRCHRNUL"

export NVIM_APPNAME=newnvim

corpo() {
    # proxy for brew
    echo "Set corpo vars"
    export http_proxy="http://127.0.0.1:9000"
    export https_proxy="http://127.0.0.1:9000"
    # export HTTP_PROXY="http://127.0.0.1:9000"
    # export HTTPS_PROXY="http://127.0.0.1:9000"
    export SSL_CERT_FILE=~/ZscalerRootCertificate-2048-SHA256.crt 
    export REQUESTS_CA_BUNDLE=~/ZscalerRootCertificate-2048-SHA256.crt
    export CORPO_NET=true
    # export ZSCALER_CERT=$(cat ~/ZscalerRootCertificate-2048-SHA256.crt)
}
uncorpo() {
    # proxy for brew
    echo "uncorpo vars"
    unset http_proxy
    unset https_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset SSL_CERT_FILE
    unset REQUESTS_CA_BUNDLE
    unset CORPO_NET
    unset ZSCALER_CERT
}

corpo

# Find wifi network SSID
# current_ssid=$(/Sy*/L*/Priv*/Apple8*/V*/C*/R*/airport -I | awk '/ SSID:/ {print $2}')
# office_ssid="CWLN"
# if [[ "$current_ssid" = "$office_ssid" ]]; then
#     corpo
# else
#     uncorpo
# fi

# CR ds aliases
alias ds-cr='gcloud run services describe --region  us-central1 datasources-datasources'
#gcloud logging read "resource.labels.service_name=datasources-datasources AND resource.type=cloud_run_revision AND resource.labels.location=us-central1" --limit 10 --order desc
# ❯ gcloud beta logging tail "resource.labels.service_name=datasources-datasources AND resource.type=cloud_run_revision AND resource.labels.location=us-central1"
alias ds-logs='gcloud beta logging tail "resource.labels.service_name=datasources AND resource.type=cloud_run_revision AND resource.labels.location=us-central1" --format="default(timestamp,resource["labels"]["instance_id"],json_payload,http_request)"'
alias f6-logs='gcloud beta logging tail "resource.labels.service_name=frontend6-datasources AND resource.type=cloud_run_revision AND resource.labels.location=us-central1"'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/phigra/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/phigra/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/phigra/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/phigra/google-cloud-sdk/completion.zsh.inc'; fi

# Created by `pipx` on 2023-04-14 19:33:55
export PATH="$PATH:/Users/phigra/.local/bin"

eval "$(atuin init zsh --disable-up-arrow)"

dependabotapprove() {
    for pr in $(gh pr list --author=app/dependabot --json number,author --jq '.[].number'); do gh pr review --approve $pr ; done
}
dependabotautomerge() {
    for pr in $(gh pr list --author=app/dependabot --json number,author --jq '.[].number'); do gh pr merge --merge --auto --delete-branch $pr ; done
}
dependabotrebase1() {
    for pr in $(gh pr list --author=app/dependabot --limit 1 --json number,author --jq '.[].number'); do gh pr comment -b "@dependabot rebase" $pr ; done
}
dependabotrebase() {
    for pr in $(gh pr list --author=app/dependabot --json number,author --jq '.[].number'); do gh pr comment -b "@dependabot rebase" $pr ; done
}

dependabotam() {
    for pr in $(gh pr list --author=app/dependabot --json number,author --jq '.[].number'); do gh pr review --approve $pr ;  gh pr merge --merge --auto --delete-branch $pr ; done
}

reset_datasource() {
    dco down -v
    direnv deny
    make start-backing-services
    direnv allow
    make run
}

# Smarter completion initialization
# autoload -Uz compinit
# if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
#     compinit
# else
#     compinit -C
# fi

alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'

# Uncomment to profile
# zprof

. "$HOME/.atuin/bin/env"
. "$HOME/.cargo/env"
