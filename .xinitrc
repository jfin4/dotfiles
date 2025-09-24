# sudo sh -c 'echo XHC0 > /proc/acpi/wakeup'
# sudo sh -c 'echo 0 > /sys/class/leds/platform::micmute/brightness'
setxkbmap -option caps:escape -option altwin:swap_alt_win
# echo true > $HOME/.swap-alt-win
# source $HOME/.fehbg
# unclutter -root -noevents &
# nm-applet &
# mullvad-vpn &
xrdb -merge .Xresources
xset b off
~/.screenlayout/external.sh


if [[ ! $WM_RUNNING ]]; then

    export WM_RUNNING=true

    dunst &
    
    # Statusbar loop
    while true; do
        xsetroot -name "$(get-status)"
        ~/.bin/watch-battery
        sleep 1m    # Update time every minute
    done &

    while true; do
        dwm 2> ~/.dwm.log
    done

fi
