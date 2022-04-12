#######################################################################
#                                path                                 #
#######################################################################

for current in /c/Program\ Files/R/*; do
    true
done
R="$current/bin"
ffmpeg="$USERPROFILE/software/ffmpeg/bin"
scripts="$HOME/scripts"
export PATH="$R:$ffmpeg:$scripts:$PATH"

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
