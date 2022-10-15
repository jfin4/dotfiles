#!/bin/sh

plugins=$(mktemp)
cat <<- EOF > $plugins
	dhruvasagar/vim-table-mode
	garbas/vim-snipmate
	godlygeek/tabular
	honza/vim-snippets
	jpalardy/vim-slime
	lifepillar/vim-mucomplete
	marcweber/vim-addon-mw-utils
	natebosch/vim-lsc
	tomtom/tlib_vim
	tpope/vim-commentary
	tpope/vim-repeat
	tpope/vim-surround
EOF

dir=$HOME/.vim/pack/pack/start
while read p; do
    if [ -e $dir/${p##*/} ]
    then
        git -C $dir/${p##*/} pull
    else
        git clone https://github.com/$p $dir/${p#*/}
    fi
done < $plugins

for d in $dir/*; do
    if ! grep -q ${d##*/} $plugins; then
        echo moved $d to opt
        mv --no-clobber $d ${dir%/start}/opt
    fi
done
