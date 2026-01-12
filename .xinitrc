#!/usr/bin/sh

xrdb -merge .Xresources
dunst &

# statusbar
while true; do
    xsetroot -name "$(get-status)"
    sleep 1m
done &

while true; do
    dwm 2> ~/.dwm.log
done
