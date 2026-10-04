#!/usr/bin/env zsh

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval $(dbus-launch --sh-syntax --exit-with-session)
    export DBUS_SESSION_BUS_ADDRESS
fi

xrdb -merge .Xresources
xset -b
export GTK_THEME=Adwaita:dark
dbus-update-activation-environment DISPLAY XAUTHORITY GTK_THEME

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
