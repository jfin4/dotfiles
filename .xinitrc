#!/usr/bin/env zsh

xrdb -merge .Xresources
xset -b 
dunst &
~/.screenlayout/$HOST.sh
# needed for xdg-desktop-portal-gtk.service (opens browser file chooser)
systemctl --user import-environment DISPLAY XAUTHORITY DBUS_SESSION_BUS_ADDRESS

~/.fehbg &

# statusbar
while true; do
    xsetroot -name "$(get-status)"
    sleep 60
done &

# update status if keyd layout changes
echo xwin > /tmp/keyd-status
keyd listen | while read -r line; do
    if [[ $line == /* ]]; then
        if [[ $line == /xwin ]]; then
            echo xwin > /tmp/keyd-status
        else
            echo tmux > /tmp/keyd-status
        fi
        xsetroot -name "$(get-status)"
    fi
done &

if [[ $USER == jfin* ]]; then 
    while true; do
        dwm 2> ~/.dwm.log
    done
else
    openbox-session
fi
