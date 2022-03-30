#!/bin/sh

plugins="
	ervandew/supertab
	garbas/vim-snipmate
	godlygeek/tabular
	honza/vim-snippets
	jpalardy/vim-slime
	marcweber/vim-addon-mw-utils
	natebosch/vim-lsc
	preservim/nerdcommenter
	tomtom/tlib_vim
	tpope/vim-repeat
	tpope/vim-surround
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
        echo moved $d to opt
        mv --no-clobber $d ${dir%/start}/opt
    fi
done
