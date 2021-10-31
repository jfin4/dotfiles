#!/bin/sh

plugins="\
	ervandew/supertab\
	godlygeek/tabular\
	sirver/ultisnips\
	tpope/vim-commentary\
	tpope/vim-repeat\
	jpalardy/vim-slime\
	honza/vim-snippets\
	tpope/vim-surround\
	"

for p in $plugins 
do
	if [ -e $HOME/.vim/pack/pack/start/"${p#*/}" ]
	then
		git -C $HOME/.vim/pack/pack/start/"${p#*/}" pull
	else
		git clone\
			https://github.com/"$p"\
			$HOME/.vim/pack/pack/start/"${p#*/}"
	fi
done
