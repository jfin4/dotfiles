#!/usr/bin/env zsh

xrdb -merge .Xresources
xset -b 
dunst &
~/.screenlayout/$HOST.sh
# needed for xdg-desktop-portal-gtk.service (opens browser file chooser)
systemctl --user import-environment DISPLAY XAUTHORITY DBUS_SESSION_BUS_ADDRESS

~/.fehbg &

# statusbar
sudo sh -c "keyd listen > /tmp/keyd_listener" &
while true; do
    xsetroot -name "$(get-status)"
    sleep 1
done &

while true; do
    dwm 2> ~/.dwm.log
done
