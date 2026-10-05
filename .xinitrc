#!/usr/bin/env bash

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh;  do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrdb .Xresources
xset -b

status_loop() {
  while true; do
    xsetroot -name "$(status)"
    sleep 60
  done
}

watch_keyd() {
  file=/run/keyd-status
  sudo touch $file
  sudo chmod 777 $file
  while read -r line; do
    if [[ $line == /* ]]; then
      [[ $line == /xwin ]] && echo xwin > $file
      [[ $line == /tmux ]] && echo tmux > $file
      xsetroot -name "$(status)"
    fi
  done < <(keyd listen)
}

case $USER in
  jfin|wb)
    watch_keyd &
    status_loop &
    while true; do
      dwm
    done
    ;;
  *) openbox-session ;;
esac



