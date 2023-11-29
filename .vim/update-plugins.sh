#!/bin/sh

# plugin github repositories
# jpalardy/vim-slime
repos='
garbas/vim-snipmate
godlygeek/tabular
honza/vim-snippets
jalvesaq/Nvim-R
lifepillar/vim-mucomplete
marcweber/vim-addon-mw-utils
preservim/vim-markdown
tomtom/tlib_vim
tpope/vim-commentary
tpope/vim-repeat
tpope/vim-surround
'

# update plugins
plugin_dir=$HOME/.vim/pack/default
for repo in $repos; do
  echo -e "\n$repo"
  plugin=${repo#*/}
  if [ -e $plugin_dir/start/$plugin ]; then
    git -C $plugin_dir/start/$plugin pull
  else
    git clone https://github.com/$repo $plugin_dir/start/$plugin
  fi
done 

