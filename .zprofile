# path
export PATH=".:$HOME/.aliases:$HOME/scripts:$PATH"

# other variables
export EDITOR=/usr/bin/vim
export TERM=xterm-256color
export ENV=$HOME/.mkshrc
export BROWSER=/bin/chromium
export _JAVA_AWT_WM_NONREPARENTING=1
export XDG_RUNTIME_DIR=/run/user/1001

if [ -z "${DISPLAY}" ]; then
# sudo /home/jfin/scripts/wakeup-disable
exec startx
fi

