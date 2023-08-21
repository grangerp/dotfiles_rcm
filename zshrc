# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/bin:$HOME/go/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"
#ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/lugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git pyenv asdf gcloud direnv docker-compose chucknorris)
plugins=(git pyenv direnv docker-compose)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
alias vim=nvim
alias vi=nvim
alias tldrf='tldr --list|fzf --preview "tldr {1} --color=always" --preview-window=right,70%|xargs tldr'
eval "$(starship init zsh)"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"

export GOPRIVATE=github.com/metriodev/schema-registry

# Find wifi network SSID
current_ssid=$(/Sy*/L*/Priv*/Apple8*/V*/C*/R*/airport -I | awk '/ SSID:/ {print $2}')
office_ssid="CWLN"

corpo() {
    # proxy for brew
    echo "Set corpo vars"
    export http_proxy="http://127.0.0.1:9000"
    export https_proxy="http://127.0.0.1:9000"
    #export SSL_CERT_FILE=~/ZscalerRootCertificate-2048-SHA256.crt 
    #export REQUESTS_CA_BUNDLE=~/ZscalerRootCertificate-2048-SHA256.crt
    export CORPO_NET=true
    #export ZSCALER_CERT=$(cat ~/ZscalerRootCertificate-2048-SHA256.crt)
}
uncorpo() {
    # proxy for brew
    echo "uncorpo vars"
    unset http_proxy
    unset https_proxy
    unset SSL_CERT_FILE
    unset REQUESTS_CA_BUNDLE
    unset CORPO_NET
    unset ZSCALER_CERT
}

if [[ "$current_ssid" = "$office_ssid" ]]; then
    corpo
else
    uncorpo
fi

# CR ds aliases
alias ds-cr='gcloud run services describe --region  us-central1 datasources-datasources'
#gcloud logging read "resource.labels.service_name=datasources-datasources AND resource.type=cloud_run_revision AND resource.labels.location=us-central1" --limit 10 --order desc
# ❯ gcloud beta logging tail "resource.labels.service_name=datasources-datasources AND resource.type=cloud_run_revision AND resource.labels.location=us-central1"
alias ds-logs='gcloud beta logging tail "resource.labels.service_name=datasources-datasources AND resource.type=cloud_run_revision AND resource.labels.location=us-central1" --format="default(timestamp,resource["labels"]["instance_id"],json_payload,http_request)"'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/phigra/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/phigra/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/phigra/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/phigra/google-cloud-sdk/completion.zsh.inc'; fi

# Created by `pipx` on 2023-04-14 19:33:55
export PATH="$PATH:/Users/phigra/.local/bin"
