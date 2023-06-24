#!/bin/sh

branch="$1"
git_dir="$HOME/.dotfiles.git"
backup="dotfiles-backup"
git clone --bare https://github.com/jfinmaniv/dotfiles "$git_dir"

function git_dot {
   git --git-dir="$git_dir" --work-tree="$HOME" "$@"
}

git_dot switch "$branch"

if [ "$?" != 0 ]
then
    mkdir "$backup"
    git_dot switch "$branch" 2>&1 \
        | grep -e "^\s+\." \
        | xargs -I{} mv {} "$backup"/{}
    git_dot switch "$branch"
fi

dot config --local status.showUntrackedFiles no
