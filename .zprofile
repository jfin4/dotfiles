# path
for current in /c/Program\ Files/R/*; do
    true
done
R="$current/bin"
dir=$(cygpath $USERPROFILE)
ffmpeg="$dir/software/ffmpeg/bin"
pandoc="$dir/software/pandoc"
scripts="$HOME/scripts"
export PATH="$R:$ffmpeg:$pandoc:$scripts:$PATH"

# env
export ENV=$HOME/.zshrc
