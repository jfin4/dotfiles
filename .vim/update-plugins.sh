#!/bin/sh

# plugin github repositories
plugins='
    garbas/vim-snipmate
    godlygeek/tabular
    honza/vim-snippets
    jalvesaq/Nvim-R
    lifepillar/vim-mucomplete
    marcweber/vim-addon-mw-utils
    tomtom/tlib_vim
    tpope/vim-commentary
    tpope/vim-repeat
    tpope/vim-surround
'

# plugin directory
dir=$HOME/.vim/pack/bundle

# move previously unused plugins back to start
for o in $(ls $dir/opt)
do
    if echo $plugins | grep -q ${o##*/}
    then
        mv --verbose $o $dir/start
    fi
done

# update plugins
for p in $plugins
do
    if [ -e $dir/start/${p##*/} ]
    then
        git -C $dir/start/${p##*/} pull
    else
        git clone https://github.com/$p $dir/start/${p#*/}
    fi
done 

# move unused plugins to opt
for s in $(ls $dir/start)
do
    if ! echo $plugins | grep -q ${s##*/}
    then
        mv --verbose $s $dir/opt
    fi
done
