#!/bin/sh

# plugins
plugins="
    AndrewRadev/sideways.vim
    garbas/vim-snipmate
    godlygeek/tabular
    honza/vim-snippets
    junegunn/fzf
    junegunn/fzf.vim
    lifepillar/vim-mucomplete
    marcweber/vim-addon-mw-utils
    mattn/vim-lsp-settings
    michaeljsmith/vim-indent-object
    prabirshrestha/vim-lsp
    tpope/vim-commentary
    tpope/vim-repeat
    tpope/vim-surround
"

# plugin directory
dir=$HOME/.vim/pack/default/start

#remove unused plugin
existing=$(\ls $dir)
for e in $existing; do
    ! echo $plugins | grep -q $e && rm -rf $dir/$e && echo removing $e
done

# update plugins
for p in $plugins; do
    echo -e "\nupdate ${p#*/}"
    git -C $dir/${p#*/} pull 2> /dev/null \
        || git clone https://github.com/$p $dir/${p#*/}
done 

# update helptags
echo -e "\nupdate helptags"
vim --not-a-term +'helptags ALL' +quit > /dev/null
