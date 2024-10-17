#!/bin/sh

# plugins
plugins='

MunifTanjim/nui.nvim
garbas/vim-snipmate
godlygeek/tabular
honza/vim-snippets
junegunn/fzf
junegunn/fzf.vim
lifepillar/vim-mucomplete
marcweber/vim-addon-mw-utils
michaeljsmith/vim-indent-object
neovim/nvim-lspconfig
nvim-lua/plenary.nvim
nvim-treesitter/nvim-treesitter
stevearc/dressing.nvim
tpope/vim-commentary
tpope/vim-repeat
tpope/vim-surround
wellle/targets.vim
yetone/avante.nvim

'

# plugin directory
dir=$HOME/.vim/pack/default/start

#remove unused plugin
existing=$(\ls $dir)
for e in $existing; do
    ! echo $plugins | grep -q $e && rm $dir/$e
done

# update plugins
for p in $plugins; do
    git -C $dir/${p#*/} pull || git clone https://github.com/$p $dir/${p#*/}
done 

# download avante binaries
if echo $plugins | grep -q avante; then
    rm $dir/avante.nvim/build/*
    powershell \
        -ExecutionPolicy Bypass \
        -File $dir/avante.nvim/Build.ps1 \
        -BuildFromSource false
fi

# update helptags
nvim -u NORC +'helptags ALL' +quit
