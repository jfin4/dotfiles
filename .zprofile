BROWSER=/usr/bin/firefox
_JAVA_AWT_WM_NONREPARENTING=1
PATH="$HOME/scripts:$PATH:."

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  sudo /home/jfin/scripts/wakeup-disable
  exec startx
fi
