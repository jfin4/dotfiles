# Set Up Development Environment


```
branch=msys
backup="~/backup"

pacman -Syu --noconfirm --needed git

git clone --bare https://github.com/jfin4/dotfiles $HOME/.dotfiles.git

function dot {
   git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME "$@"
}

dot config --local status.showUntrackedFiles no

dot switch $branch 2> /dev/null

if [ $? != 0 ]; then
    mkdir -p $backup
    dot switch $branch 2>&1 \
        | grep -e '	' \
        | awk {'print $1'} \
        | sed -e 's/\/.*//' \
        | uniq \
        | xargs -I{} mv {} $backup/{}
    dot switch $branch
fi

# git clone https://github.com/jfin4/scripts
# git clone https://github.com/jfin4/secrets $HOME/.password-store
# pacman -Syu --noconfirm --needed pass
# pass show github.com/personal-access-token > $HOME/.git-credentials
```
