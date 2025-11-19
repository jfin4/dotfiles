#!/usr/bin/zsh

os=$(uname)
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ] && [ $os = "Linux" ]; then
    kernel=$(pacman -Qu linux)
    sudo pacman -Syu --noconfirm
    if [[ -n $kernel ]]; then
        echo updated kernel. rebooting...
        sudo reboot
    fi
    startx
fi

