#!/usr/bin/sh

xrdb -merge .Xresources
# xset b off
# dunst &
cwm 2> ~/.cwm.log
