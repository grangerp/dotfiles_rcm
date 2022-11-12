#!/bin/bash
[[ -r ~/.bashrc ]] && . ~/.bashrc
if [ -e /home/pgranger/.nix-profile/etc/profile.d/nix.sh ]; then . /home/pgranger/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
. "$HOME/.cargo/env"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Created by `pipx` on 2022-05-22 12:14:59
export PATH="$PATH:/home/pgranger/.local/bin"
