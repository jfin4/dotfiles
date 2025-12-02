#!/bin/sh

branch=main

cd $HOME 

git_dir=.dotfiles.git
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
    dot switch $branch 2>&1 | grep -E $'\t' | sed -e $'s/\t\\([^/]*\\).*/\\1/' | uniq \
        | xargs -I{} mv {} $backup_dir/{}
    dot switch $branch
fi

dot restore .

dot pull --set-upstream origin $branch

cd -
