#!/usr/bin/zsh

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    sudo pacman -Syu --noconfirm
fi

