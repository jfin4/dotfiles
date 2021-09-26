source $HOME/.fehbg
xset b off
xrdb -merge .Xresources
unclutter -root -noevents &
sudo sh -c 'echo 0 > /sys/class/leds/platform::micmute/brightness'

# status bar
status-print | status-draw &

cwm
