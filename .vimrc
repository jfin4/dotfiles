" vim: set ft=vim :
filetype indent plugin on
syntax on
colorscheme jfin

source $VIMRUNTIME/defaults.vim

if has('gui_running') && has('win32')
    set backupdir=C:\\Users\\JInman\\msys\\home\\jfin\\.vim\\backup
    set directory=C:\\Users\\JInman\\msys\\home\\jfin\\.vim\\swap
    set undodir=C:\\Users\\JInman\\msys\\home\\jfin\\.vim\\undo 
    set viminfo+=nC:\\Users\\JInman\\msys\\home\\jfin\\.vim\\viminfo
else
    set backupdir=~/.vim/backup
    set directory=~/.vim/swap
    set undodir=~/.vim/undo 
    set viminfo+=n~/.vim/viminfo
endif

set guioptions=egt
set guicursor+=a:blinkon0
set guifont=Terminus_(TTF)_for_Windows:h12:b

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
set formatoptions=qljt  
set ignorecase 
set laststatus=1
set linebreak 
set nohlsearch
set pastetoggle=<insert> 
set shiftround 
set shiftwidth=4 
set showbreak=+
set smartcase 
set tabstop=4 
set textwidth=78 
set title
set undofile 
set virtualedit=block
set wildmenu

" variables
let mapleader = ' '
let maplocalleader = ' '

" maps
inoremap jk <esc>
nnoremap <c-j> :bnext<cr>
nnoremap <c-k> :bprevious<cr>
nnoremap <backspace> :bdelete<cr>
vnoremap Y "+y

" vimrc
nnoremap <leader>vi :e $MYVIMRC<cr>
nnoremap <leader>ci :e $HOME\vimfiles\colors\jfin.vim<cr>
augroup vimrc
    au!
    autocmd BufWritePost $MYVIMRC,*.vim source $MYVIMRC
augroup end

" noexpandtab
augroup shell
    au!
    autocmd FileType make,sh set noexpandtab

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

"slime
" let g:slime_python_ipython = 1
let g:slime_bracketed_paste = 1
let g:slime_target = "tmux"
let g:slime_no_mappings = 1
let g:slime_default_config = {"socket_name": "repl", "target_pane": "0"}
let g:slime_dont_ask_default = 1

xmap , <Plug>SlimeRegionSend
nmap , <Plug>SlimeLineSend


" open repl
function! OpenREPL(socketName, ...)
  let l:interpreter = a:0 > 0 ? a:1 : ''
  if l:interpreter == ''
    " Guess interpreter based on the filetype
    if &filetype == 'python'
        let l:interpreter = 'python'
    elseif &filetype == 'r'
        let l:interpreter = 'R'
    else
        let l:interpreter = 'zsh'
    endif
  endif
  let l:tmuxCommand = 'xterm -e tmux -L ' . a:socketName . ' new-session ' . l:interpreter . ' &'
  call system(l:tmuxCommand)
endfunction

nnoremap <leader>ri :call OpenREPL('repl')<cr>
