" vim: set ft=vim :
filetype indent plugin on
syntax on
colorscheme jfin

source $VIMRUNTIME/defaults.vim

set backupdir=c:/msys64/home/JInman/.vim/backup
set directory=c:/msys64/home/JInman/.vim/swap
set undodir=c:/msys64/home/JInman/.vim/undo 
set viewdir=c:/msys64/home/JInman/.vim/view
set viminfo+=nc:/msys64/home/JInman/.vim/viminfo

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
set foldtext=getline(v:foldstart)[0:30].repeat('>',48)
set formatoptions=qljnro
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

" comments
let b:commentary_startofline = 1

" variables
let mapleader = ' '
let maplocalleader = ' '
let g:netrw_browsex_viewer = 'shellescape(C:\Users\jinman\AppData\Local\Firefox Developer Edition\firefox.exe)'

" maps
inoremap jk <esc>
xnoremap Y "*y

" vimrc
augroup vimrc
    au!
    autocmd BufWritePost _vimrc,.vimrc,*.vim source $MYVIMRC
augroup end

" auto reload snipmate configuration
augroup vimrc
    au!
    autocmd BufWritePost _.snippet SnipMateLoadScope _
augroup end

" remember folds
augroup remember_folds
  autocmd!
  autocmd BufWinLeave *.r mkview
  autocmd BufWinEnter *.r silent! loadview
augroup END

" get highlight group
function! GetHighlight()
    let hi    = synIDattr(synID(line('.'), col('.'), 1), 'name')
    let trans = synIDattr(synID(line('.'), col('.'), 0), 'name')
    let lo    = synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    echo 'hi:' . hi . ', trans:' . trans . ', lo:' . lo
endfunction
nnoremap <leader>hi :call GetHighlight()<cr>

" open file under cursor
function! OpenLink()
  let l:link = trim(getline('.'))
  if has('gui_running') && has('win32')
    call system('start "" ' . shellescape(l:link))
  else
    call system('cygstart ' . shellescape(l:link))
  endif
endfunction
nnoremap <cr> :call OpenLink()<cr>


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
augroup snipmate
   au!
   autocmd bufread * SnipMateLoadScope %
augroup end

" mucomplete
imap <expr> . mucomplete#extend_fwd(".")

" nvim-r
let R_user_maps_only = 1
