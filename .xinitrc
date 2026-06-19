#!/usr/bin/env zsh

xrdb -merge .Xresources
xset -b
systemctl --user import-environment DISPLAY XAUTHORITY DBUS_SESSION_BUS_ADDRESS
~/.fehbg

if [[ $USER == jfin* ]]; then
    sudo pkill -f dunst; dunst &
    sudo pkill -f update-status; update-status &
    sudo pkill -f update-keyd-status; update-keyd-status &
    pgrep -u $USER -f dwm || while true; do
        dwm
    done
else
    pgrep -u $USER -f openbox || openbox-session
fi
