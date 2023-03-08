# path
for current in /c/Program\ Files/R/*; do
    true
done
R="$current/bin"
dir=$(cygpath $USERPROFILE)
ffmpeg="$dir/software/ffmpeg/bin"
pandoc="$dir/software/pandoc"
scripts="$HOME/scripts"
firefox=/c/Users/JInman/PortableApps/FirefoxPortable/App/Firefox64/updated/
export PATH="$R:$ffmpeg:$pandoc:$scripts:$firefox:$PATH"

# env
export ENV=$HOME/.zshrc
