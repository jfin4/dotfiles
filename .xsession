#!/bin/sh

# path
export PATH=".:$HOME/scripts:$PATH"

# other variables
export EDITOR=/usr/local/bin/vim
export TERM=xterm-256color
export ENV=$HOME/.kshrc
export LC_CTYPE="en_US.UTF-8"

# firefox
export MOZ_ACCELERATED=1
export MOZ_WEBRENDER=1


# fonts
for font in /usr/local/share/fonts/*
do
	xset +fp $font
done

# x utilities
xset b off
xrdb .Xresources
unclutter -root -noevents &

# doas ntfs-3g /dev/sd2i /mnt/shared

# status bar
status-print | status-draw &

cwm
