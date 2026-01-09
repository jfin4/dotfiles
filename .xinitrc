#!/usr/bin/sh

# sudo sh -c 'echo XHC0 > /proc/acpi/wakeup'
xrdb -merge .Xresources
xset b off
~/.screenlayout/external.sh

if [[ ! $WM_RUNNING ]]; then

    export WM_RUNNING=true

    dunst &

    # Statusbar loop
    while true; do
        xsetroot -name "$(get-status)"
        watch-battery
        sleep 1m    # Update time every minute
    done &

    while true; do
        dwm 2> ~/.dwm.log
    done

fi
