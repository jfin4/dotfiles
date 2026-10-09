#!/usr/bin/env bash

# common
# ------------------------------------------------------------------------------

xrdb ~/.Xresources
xset -b
dunst &

# handles dbus for firefox file picker
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh;  do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

jfin_users=(jfin wb)
is_jfin_user=0

for u in "${jfin_users[@]}"; do
  [[ $u == "$USER" ]] && { is_jfin_user=1; break; }
done

# guest
# ------------------------------------------------------------------------------
if (( ! is_jfin_user )); then
  exec openbox-session
fi

# jfin accounts
# ------------------------------------------------------------------------------

# status bar
while true; do
  xsetroot -name "$(status)"
  sleep 60
done &

# keyd layout indicator
keyd_layout=/run/keyd-layout
sudo install -m 666 /dev/null "$keyd_layout"
while read -r line; do
  if [[ $line == /* ]]; then
    [[ $line == /xwin ]] && echo > $keyd_layout
    [[ $line == /tmux ]] && echo tmux > $keyd_layout
    xsetroot -name "$(status)"
  fi
done < <(keyd listen) &

while true; do
  dwm
done
