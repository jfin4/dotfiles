#!/bin/sh

plugins="
	godlygeek/tabular
	honza/vim-snippets
	jpalardy/vim-slime
	preservim/nerdcommenter
	sirver/ultisnips
	tpope/vim-repeat
	tpope/vim-surround
    ackyshake/VimCompletesMe
    lifepillar/vim-mucomplete
    natebosch/vim-lsc
	"

dir=$HOME/.vim/pack/pack/start
for p in $plugins 
do
    if [ -e $dir/${p##*/} ]
    then
        git -C $dir/${p##*/} pull
    else
        git clone https://github.com/$p $dir/${p#*/}
    fi
done

for d in $dir/*; do
    if ! { echo "$plugins" | grep -q ${d##*/}; }; then
        echo move-to-trash $d
        move-to-trash $d
    fi
done
