# path
export PATH=".:$HOME/.local/bin:$HOME/scripts:$PATH"

# other variables
export EDITOR=/usr/bin/vim
export TERM=xterm-256color
export ENV=$HOME/.mkshrc
export BROWSER=/usr/bin/firefox
export _JAVA_AWT_WM_NONREPARENTING=1

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
# sudo /home/jfin/scripts/wakeup-disable
exec startx
fi

