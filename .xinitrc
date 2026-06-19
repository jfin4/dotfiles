#!/usr/bin/env zsh

xrdb -merge .Xresources
xset -b
systemctl --user import-environment DISPLAY XAUTHORITY DBUS_SESSION_BUS_ADDRESS
~/.fehbg

if [[ $USER == jfin* ]]; then
    pkill -u $USER -f dunst; dunst &
    pkill -u $USER -f update-status; update-status &
    pkill -u $USER -f update-keyd-status; update-keyd-status &
    pgrep -u $USER -f dwm || while true; do
        dwm
    done
else
    pgrep -u $USER -f openbox || openbox-session
fi
