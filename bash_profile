#!/bin/bash
[[ -r ~/.bashrc ]] && . ~/.bashrc
if [ -e /home/pgranger/.nix-profile/etc/profile.d/nix.sh ]; then . /home/pgranger/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
. "$HOME/.cargo/env"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
