# Set Up Development Environment


```
[ -z "$1" ] && echo need branch && return
branch=$1

git_dir=$HOME/.dotfiles.git
[ -d $git_dir ] && rm -rf $git_dir

git clone --bare https://github.com/jfin4/dotfiles $git_dir

function dot {
   git --git-dir=$git_dir --work-tree=$HOME "$@"
}

dot switch $branch 2> /dev/null

if [ $? != 0 ]; then
    backup_dir=$HOME/dotfiles-backup
    mkdir -p $backup_dir
    dot switch $branch 2>&1 | grep -e '	' | sed -e 's/	\(.*\).*/\1/' | uniq \
        | xargs -I{} mv {} $backup_dir/{}
    dot switch $branch
fi
```
