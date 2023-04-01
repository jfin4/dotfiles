dunst &
# setxkbmap -option caps:escape -option altwin:swap_alt_win
setxkbmap -option caps:escape
echo true > $HOME/.swap-alt-win
source $HOME/.fehbg
unclutter -root -noevents &
nm-applet &
mullvad-vpn &
watch-battery &
xrdb -merge .Xresources
xset b off

exec awesome
# exec startlxqt
