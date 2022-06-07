feh --no-fehbg --bg-fill '/home/jfin/.sunset-above-clouds.jpg' 
# sudo sh -c 'echo 0 > /sys/class/leds/platform::micmute/brightness'
xrdb -merge .Xresources
xset b off

XDG_RUNTIME_DIR=/run/user/$(id -u)
sudo mkdir --mode=700 $XDG_RUNTIME_DIR
sudo chown jfin:jfin $XDG_RUNTIME_DIR

dunst &
pipewire &
pipewire-pulse &
unclutter -root -noevents &

exec cwm
