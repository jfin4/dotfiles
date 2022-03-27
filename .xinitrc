$HOME/.fehbg
unclutter -root -noevents &
xrdb -merge .Xresources
xset b off
dunst &

# exec start-dwm
exec cwm
