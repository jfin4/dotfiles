#!/usr/bin/sh

xrdb -merge .Xresources
xset -b 
dunst &
~/.screenlayout/$HOST.sh

statusbar
while true; do
    xsetroot -name "$(get-status)"
    sleep 1m
done &

while true; do
    dwm 2> ~/.dwm.log
done
