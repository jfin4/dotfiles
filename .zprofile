#######################################################################
#                                path                                 #
#######################################################################

for current in /c/Program\ Files/R/*; do
    true
done
R="$current/bin"
brave="/c/Users/$USER/AppData/Local/BraveSoftware/Brave-Browser/Application"
ffmpeg="/c/Users/$USER/ffmpeg"
node="/c/Users/$USER/node"
pandoc="/c/Users/$USER/pandoc"
scripts="$HOME/scripts"
sumatra="/c/Users/$USER/sumatra-pdf"
texlive="/c/Users/$USER/texlive/2021/bin/win32"
export PATH="$R:$scripts:$brave:$ffmpeg:$node:$pandoc:$sumatra:$texlive:$PATH"

#######################################################################
#                              variables                              #
#######################################################################

export EDITOR=/usr/bin/vim
export TERM=xterm-256color
export BROWSER="$brave/brave.exe"
export LC_ALL=C

#######################################################################
#                            envioronment                             #
#######################################################################

export ENV=$HOME/.zshrc
