#!/usr/bin/env zsh

xrdb -merge .Xresources
xset -b
systemctl --user import-environment DISPLAY XAUTHORITY DBUS_SESSION_BUS_ADDRESS
~/.fehbg

if [[ $USER == jfin* ]]; then
    pkill -f dunst; dunst &
    pkill -f update-status; update-status &
    pkill -f update-keyd-status; update-keyd-status &
    pgrep -u $USER -f dwm || while true; do
        dwm
    done
else
    pgrep -u $USER -f openbox || openbox-session
fi
