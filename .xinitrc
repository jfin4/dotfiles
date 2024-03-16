sudo sh -c 'echo XHC0 > /proc/acpi/wakeup'
# sudo sh -c 'echo 0 > /sys/class/leds/platform::micmute/brightness'
dunst &
# setxkbmap -option caps:escape -option altwin:swap_alt_win
setxkbmap -option caps:escape
echo true > $HOME/.swap-alt-win
# source $HOME/.fehbg
unclutter -root -noevents &
nm-applet &
mullvad-vpn &
xrdb -merge .Xresources
xset b off

# Statusbar loop
while true; do
   # xsetroot -name "$( date +"%F %R" )"
   xsetroot -name "$( get-status )"
   sleep 1m    # Update time every minute
done &

# # live wallpaper loop
# while true; do
#     mpv mpv -wid 0 --loop --no-audio ~/.chimp.mkv
#     sleep 1
# done &

exec start-dwm

