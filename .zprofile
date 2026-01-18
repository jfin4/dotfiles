#!/usr/bin/sh

# path
[ -z "$initial_path" ] && initial_path="$PATH"
PATH="$HOME/.bin" 
PATH="$PATH:$HOME/.local/bin" 
PATH="$PATH:$initial_path"
# startx needs HOST
export initial_path PATH HOST

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    if ping -c 1 -W 2 8.8.8.8 &> /dev/null; then
        kernel=$(sudo pacman -Syu --print | grep -o "linux-[0-9.]\+")
        sudo pacman -Syu --noconfirm

        if [[ -n $kernel ]]; then
            read -p "kernel updated. reboot? [y/N] " response
            if [[ "$response" == y ]]; then
                sudo reboot
            fi
        fi
    fi

    # start x
    startx
fi

