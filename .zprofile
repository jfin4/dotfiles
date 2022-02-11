#######################################################################
#                                path                                 #
#######################################################################

brave="/c/Users/$USER/AppData/Local/BraveSoftware/Brave-Browser/Application"
ffmpeg="/c/Users/$USER/ffmpeg"
pandoc="/c/Users/$USER/pandoc"
scripts="$HOME/scripts"
sumatra="/c/Users/$USER/sumatra-pdf"
texlive="/c/Users/$USER/texlive/2021/bin/win32"
export PATH=".:$brave:$ffmpeg:$pandoc:$sumatra:$texlive:$scripts:$PATH"

#######################################################################
#                              variables                              #
#######################################################################

export EDITOR=/usr/bin/vim
export TERM=xterm-256color
export BROWSER="$firefox/firefox.exe"
export LC_ALL=C

#######################################################################
#                            envioronment                             #
#######################################################################

export ENV=$HOME/.zshrc
