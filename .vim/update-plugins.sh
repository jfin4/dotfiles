 #!/bin/sh
 
plugins=$(mktemp)
cat <<- EOF > $plugins
	garbas/vim-snipmate
	godlygeek/tabular
	honza/vim-snippets
	jpalardy/vim-slime
	lifepillar/vim-mucomplete
	marcweber/vim-addon-mw-utils
	natebosch/vim-lsc
	preservim/nerdcommenter
	tomtom/tlib_vim
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
        mv $d ${dir%/start}/opt
        [ "$?" = 0 ] && echo moved $d to opt
    fi
done
