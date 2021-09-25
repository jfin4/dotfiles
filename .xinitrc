source $HOME/.fehbg
xset b off
xrdb .Xresources
unclutter -root -noevents &

# doas ntfs-3g /dev/sd2i /mnt/shared

# status bar
status-print | status-draw &

cwm
