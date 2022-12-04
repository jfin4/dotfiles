dunst &
setxkbmap -option caps:escape -option altwin:swap_alt_win
echo true > $HOME/.swap-alt-win
sudo sh -c 'echo XHC0 > /proc/acpi/wakeup'
source $HOME/.fehbg
sudo sh -c 'echo 0 > /sys/class/leds/platform::micmute/brightness'
unclutter -root -noevents &
watch-battery &
xrdb -merge .Xresources
xset b off

exec awesome
