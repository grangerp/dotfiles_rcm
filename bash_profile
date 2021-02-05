#!/bin/bash
[[ -r ~/.bashrc ]] && . ~/.bashrc
if [ -e /home/pgranger/.nix-profile/etc/profile.d/nix.sh ]; then . /home/pgranger/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer



# Created by `userpath` on 2021-01-22 20:45:37
export PATH="$PATH:/Users/philippe.granger/.local/bin"
