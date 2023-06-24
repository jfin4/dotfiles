" vim: set ft=vim :
filetype indent plugin on
syntax on
colorscheme jfin

source $VIMRUNTIME/defaults.vim

if has('gui_running') && has('win32')
    set backupdir=$LOCALAPPDATA/Programs/msys64/home/JInman/.vim/backup
    set directory=$LOCALAPPDATA/Programs/msys64/home/JInman/.vim/swap
    set undodir=$LOCALAPPDATA/Programs/msys64/home/JInman/.vim/undo 
    set viminfo+=n$LOCALAPPDATA/Programs/msys64/home/JInman/.vim/viminfo
else
    set backupdir=$HOME/.vim/backup
    set directory=$HOME/.vim/swap
    set undodir=$HOME/.vim/undo 
    set viminfo+=n$HOME/.vim/viminfo
endif

set guioptions=egt
set guicursor+=a:blinkon0
set guifont=Terminus_(TTF)_for_Windows:h12

set autoindent 
set autoread 
set autowriteall
set breakindent 
set breakindentopt=min:0,shift:1
set completeopt=menu,menuone " mucomplete needs menuone
set encoding=utf-8
set expandtab 
set fillchars=vert:\ ,fold:\ ,eob:\ 
set foldlevel=99
set foldmethod=manual
set foldtext=getline(v:foldstart)[0:30].repeat('>',48)
set formatoptions=qlj  
set ignorecase 
set laststatus=1
set linebreak 
set nohlsearch
set pastetoggle=<insert> 
set shiftround 
set shiftwidth=2 
set showbreak=+
set smartcase 
set tabstop=2 
set textwidth=78 
set undofile 
set virtualedit=block
set wildmenu

" variables
let mapleader = ' '
let maplocalleader = ' '
if has('gui_running') && has('win32')
  let g:netrw_browsex_viewer = 'cygstart'
endif

" maps
inoremap jk <esc>
xnoremap Y "*y

" vimrc
nnoremap <leader>vi :e $MYVIMRC<cr>
nnoremap <leader>ci :e c:/users/jinman/appdata/local/programs/msys64/home/jinman/.vim/colors/jfin.vim<cr>
augroup vimrc
    au!
    autocmd BufWritePost _vimrc,.vimrc,*.vim source $MYVIMRC
augroup end

" get highlight group
function! GetHighlight()
    let hi    = synIDattr(synID(line('.'), col('.'), 1), 'name')
    let trans = synIDattr(synID(line('.'), col('.'), 0), 'name')
    let lo    = synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    echo 'hi:' . hi . ', trans:' . trans . ', lo:' . lo
endfunction
nnoremap <leader>hi :call GetHighlight()<cr>

" command abbreviations
cnoreabbrev h tab h

" snipmate
let g:snipMate = get(g:, 'snipMate', {
            \ 'always_choose_first' : 1,
            \ 'no_match_completion_feedkeys_chars' : '',
            \ 'snippet_version' : 1,
            \ })
imap <c-l> <Plug>snipMateNextOrTrigger
smap <c-l> <Plug>snipMateNextOrTrigger
smap <c-h> <Plug>snipMateBack
nnoremap <leader>si :SnipMateOpenSnippetFiles<cr>
augroup snipmate
   au!
   autocmd bufread * SnipMateLoadScope %
augroup end

" mucomplete
imap <expr> . mucomplete#extend_fwd(".")


