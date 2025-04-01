#!/usr/bin/bash

[ -z "$1" ] && echo need branch && exit
branch=$1

git_dir=$HOME/.dotfiles.git
[ -d $git_dir ] && \rm -rf $git_dir
git clone --bare https://github.com/jfin4/dotfiles $git_dir

function dot {
   git --git-dir=$git_dir --work-tree=$HOME "$@"
}
dot switch $branch 2> /dev/null
if [ $? != 0 ]; then
    backup_dir=$HOME/dotfiles-backup
    [ -d $backup_dir ] && \rm -rf $backup_dir
    mkdir -p $backup_dir
    dot switch $branch 2>&1 | grep -Pe '\t' | sed -e 's/\t\([^/]*\).*/\1/' | uniq \
        | xargs -I{} mv $HOME/{} $backup_dir/{}
    dot switch $branch
fi

# because crlf
dot restore $HOME/. 

dot pull --set-upstream origin $branch
