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
[[ -f ~/.keyd_layout ]] || echo xwin > ~/.keyd_layout
keyd listen | grep --line-buffered "/" | while read -r line; do
    [[ $layout == xwin ]] && layout=tmux || layout=xwin
    echo $layout > ~/.keyd_layout
    xsetroot -name "$(get-status)"
done &

while true; do
    dwm 2> ~/.dwm.log
done
