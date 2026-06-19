#!/usr/bin/env zsh

xrdb -merge .Xresources
xset -b
systemctl --user import-environment DISPLAY XAUTHORITY DBUS_SESSION_BUS_ADDRESS
~/.fehbg

case $USER in
    jfin|jfin-wb)
        pgrep -f update-keyd-status -u $USER || update-keyd-status &
        pgrep -f update-status -u $USER || update-status &
        pgrep -f dwm -u $USER || while true; do
            dwm
        done
    ;;
    *)
        pgrep -f openbox -u $USER || openbox-session
    ;;
esac
