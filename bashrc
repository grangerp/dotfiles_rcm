[ -f ~/.fzf.bash ] && source ~/.fzf.bash
. "$HOME/.cargo/env"

. "$HOME/.atuin/bin/env"

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"
