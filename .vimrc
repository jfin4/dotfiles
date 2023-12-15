" vim: set ft=vim :
filetype indent plugin on
syntax on
colorscheme jfin

" variables
let mapleader = ' '
let maplocalleader = ' '

" settings
source $VIMRUNTIME/defaults.vim

set backupdir=c:/msys64/home/JInman/.vim/backup
set directory=c:/msys64/home/JInman/.vim/swap
set undodir=c:/msys64/home/JInman/.vim/undo 
set viewdir=c:/msys64/home/JInman/.vim/view
set viminfo+=nc:/msys64/home/JInman/.vim/viminfo

set guioptions=egt
set guicursor+=a:blinkoff500-blinkon500
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

" functions

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

" maps
inoremap jk <esc>
xnoremap Y "*y

" command abbreviations
cnoreabbrev h tab help

" auto commands

" vimrc
augroup vimrc
    au!
    autocmd BufWritePost _vimrc,.vimrc,*.vim source $MYVIMRC
augroup end

" markdown
augroup markdown
  autocmd!
  autocmd Filetype markdown set formatoptions+=o
augroup END

" plug-ins

" snipmate
let g:snipMate = get(g:, 'snipMate', {
            \ 'always_choose_first' : 1,
            \ 'no_match_completion_feedkeys_chars' : '',
            \ 'snippet_version' : 1,
            \ })

imap <c-l> <Plug>snipMateNextOrTrigger
smap <c-l> <Plug>snipMateNextOrTrigger
smap <c-h> <Plug>snipMateBack

augroup snippets
    au!
    autocmd BufWritePost *.snippet SnipMateLoadScope %
augroup end

" mucomplete
let g:mucomplete#chains = {
    \ 'default' : ['path', 'omni', 'keyp', 'dict', 'uspl'],
    \ 'vim'     : ['path', 'cmd', 'keyn']
    \ }
imap <expr> . mucomplete#extend_fwd(".")

" slime
let g:slime_target = "tmux"
let g:slime_no_mappings = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}
let g:slime_dont_ask_default = 1

function! OpenREPL()
  call system('open-repl ' . &filetype) 
endfunction

nnoremap <localLeader>ri :call OpenREPL()<cr>
nnoremap <silent> <localLeader>ro :!tmux kill-pane -t {bottom-right}<cr>

xnoremap , <Plug>SlimeRegionSend
" nnoremap , <Plug>SlimeMotionSend
nnoremap , <Plug>SlimeLineSend
