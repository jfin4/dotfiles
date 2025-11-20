#!/usr/bin/sh

# path
[ -z "$initial_path" ] && initial_path="$PATH"
PATH="$HOME/.bin" 
PATH="$PATH:$HOME/.local/bin" 
PATH="$PATH:$initial_path"
export initial_path PATH

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    # kernel=$(pacman -Qu linux)
    # sudo pacman -Syu --noconfirm
    # if [[ -n $kernel ]]; then
    #     echo updated kernel. rebooting...
    #     sudo reboot
    # fi
    startx
fi

