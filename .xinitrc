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
keyd listen | grep "/" | while read -r line; do
    get-keyd-layout
done &

while true; do
    dwm 2> ~/.dwm.log
done
