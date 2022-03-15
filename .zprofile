#######################################################################
#                                path                                 #
#######################################################################

brave="/c/Users/$USER/AppData/Local/BraveSoftware/Brave-Browser/Application"
ffmpeg="/c/Users/$USER/ffmpeg"
pandoc="/c/Users/$USER/pandoc"
scripts="$HOME/scripts"
sumatra="/c/Users/$USER/sumatra-pdf"
texlive="/c/Users/$USER/texlive/2021/bin/win32"
export PATH="$scripts:$brave:$ffmpeg:$pandoc:$sumatra:$texlive:$PATH"

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
