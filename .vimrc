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
set formatoptions=qljnr
set ignorecase 
set laststatus=1
set linebreak 
set nohlsearch
set pastetoggle=<insert> 
set shell=/usr/bin/sh
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
nnoremap <c-j> :bnext<cr>
nnoremap <c-k> :bprevious<cr>
nnoremap <backspace> :bdelete<cr>

" command abbreviations
cnoreabbrev h tab help

" auto commands

" folds
augroup folds
  au!
  autocmd BufWinEnter * if getline(1) =~ 'foldenable' | execute 'loadview' | endif
  autocmd BufWinLeave * if getline(1) =~ 'foldenable' | execute 'mkview!' | endif
augroup end


" vimrc
augroup vimrc
    au!
    autocmd BufWritePost _vimrc,.vimrc,*.vim source $MYVIMRC
augroup end

" markdown
augroup markdown
  autocmd!
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
let g:slime_default_config = {"socket_name": "repl", "target_pane": "0"}
let g:slime_dont_ask_default = 1

nnoremap <localLeader>ri :call system('open-repl ' . 'repl ' . &filetype)<cr>
nnoremap <localLeader>r2 :call system('open-repl ' . 'repl2 ' . &filetype)<cr>

xnoremap , <Plug>SlimeRegionSend
" nnoremap , <Plug>SlimeMotionSend
nnoremap , <Plug>SlimeLineSend

" markdown
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
