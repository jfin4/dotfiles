source $HOME/.fehbg
sudo sh -c 'echo 0 > /sys/class/leds/platform::micmute/brightness'
unclutter -root -noevents &
xrdb -merge .Xresources
xset b off
xsetkb
dunst &

exec startdwm
