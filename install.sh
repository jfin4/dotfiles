#!/bin/sh


repo_url="https://github.com/jfin4/dotfiles"

# checkout main branch by default
branch="${1:-main}"

cd $HOME

git_dir=.dotfiles.git
[[ -d "$git_dir" ]] && rm -rf "$git_dir"
git clone --bare "$repo_url" "$git_dir"

function dot {
   git --git-dir=$git_dir --work-tree=$HOME "$@"
}

existing_files=$(\
    dot switch "$branch" 2>&1 |\
    grep "^	" |\
    sed "s/^	//" |\
    uniq
)

if [[ -n "$existing_files" ]]; then
    bak_dir=dotfiles.bak
    if [[ -d "$bak_dir" ]]; then
        echo
        echo "$bak_dir exists; rename to backup up files"
        echo "exiting"
        exit
    fi
    mkdir "$bak_dir"
    # copy top level directories of exiting files to maintain directory
    # structure
    echo "$existing_files" | \
        sed "s/\/.*//" | \
        uniq | \
        xargs -I{} cp -r {} "$bak_dir"
    # remove only files, leaving parent directories, e.g., ~/.config
    echo "$existing_files" | \
        xargs -I{} rm {}
fi

dot switch "$branch"

# # addresses cr/lf compatibility issue between dos/unix
dot restore .

dot pull --set-upstream origin "$branch"

cd -
