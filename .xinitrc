#!/usr/bin/env zsh

xrdb -merge .Xresources
xset -b
systemctl --user import-environment DISPLAY XAUTHORITY DBUS_SESSION_BUS_ADDRESS
[[ -f ~/.fehbg ]] && ~/.fehbg
export GTK_THEME=Adwaita:dark

case $USER in
    jfin*)
        pgrep -u $USER -f update-keyd-status || update-keyd-status &
        pgrep -u $USER -f update-status || update-status &
        pgrep -u $USER -f dwm || while true; do
            dwm
        done
    ;;
    *)
        ~/.fehbg
        pgrep -u $USER -f openbox || openbox-session
    ;;
esac
