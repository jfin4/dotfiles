#######################################################################
#                                path                                 #
#######################################################################

winhome=$(cygpath --windows "$USERPROFILE")
for current in /c/Program\ Files/R/*; do
    true
done
R="$current/bin"
ffmpeg="$winhome/software/ffmpeg"
scripts="$HOME/scripts"
sumatra="$winhome/software/sumatra-pdf"
export PATH="$R:$scripts:$ffmpeg:$sumatra:$PATH"

#######################################################################
#                              variables                              #
#######################################################################

export EDITOR=/usr/bin/vim
export TERM=xterm-256color
export BROWSER='/c/Program Files (x86)/Google/Chrome/Application/chrome.exe'
export LC_ALL=C

#######################################################################
#                            envioronment                             #
#######################################################################

export ENV=$HOME/.zshrc
