#!/bin/sh

branch="$1"

if [ -z "$branch" ]
then
	echo "Usage: $0 BRANCH"
	exit
fi

git_dir="$HOME/.dotfiles.git"
backup="$HOME/dotfiles-backup"

if [ -d "$git_dir" ]
then
	rm -rf "$git_dir"
fi

git clone --bare https://github.com/jfinmaniv/dotfiles "$git_dir"

function git_dot {
   git --git-dir="$git_dir" --work-tree="$HOME" "$@"
}

git_dot switch "$branch"  > /dev/null 2>&1

if [ "$?" != 0 ]
then
    echo "Moved existing dotfiles to $backup."

    if [ -d "$backup" ]
    then
    	rm -rf "$backup"
    fi
    mkdir "$backup"
    
    existing_dotfiles=$(git_dot switch "$branch" 2>&1 | grep -e "^\s\+")

    for path in $existing_dotfiles
    do
      dir="${path%/*}"
      if [ -d "$dir" ]
      then
        mkdir --parent "$backup"/"$dir"
        mv "$path" "$backup"/"$dir"
        continue
      fi
      mv "$path" "$backup"
    done

    git_dot switch "$branch"
fi

git_dot config --local status.showUntrackedFiles no
