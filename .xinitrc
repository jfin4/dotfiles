dunst &
setxkbmap -option caps:escape
source $HOME/.fehbg
sudo sh -c 'echo 0 > /sys/class/leds/platform::micmute/brightness'
unclutter -root -noevents &
xrdb -merge .Xresources
xset b off

exec spectrwm
