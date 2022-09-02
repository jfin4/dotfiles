# path
for current in /c/Program\ Files/R/*; do
    true
done
R="$current/bin"
user=$(cygpath $USERPROFILE)
ffmpeg="$user/software/ffmpeg/bin"
pandoc="$user/software/pandoc/"
scripts="$HOME/scripts"
export PATH="$R:$ffmpeg:$pandoc:$scripts:$PATH"

# env
export ENV=$HOME/.zshrc
