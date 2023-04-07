" vimrc
filetype indent plugin on 
syntax on 
colorscheme jfin

" options 
set autoindent " take indent for new line from previous line
set autoread " automatically read file when changed outside of vim
set autowriteall " automatically write file if changed
set backspace=indent,eol,start " Allow backspacing over everything in insert mode.
set backupdir=~/.vim/backup
set breakindent " wrapped lines are indented same as beginning of line
set breakindentopt=min:0,shift:1 " wrapped lines are indented same as beginning of line
set completeopt=menu,menuone
set directory=~/.vim/swap
set display=lastline " Show @@@ in the last line if it is truncated.
set encoding=utf-8
set expandtab " use spaces when <tab> is inserted
set fillchars=vert:\ ,fold:\ ,eob:\ 
set foldlevel=99
set foldmethod=manual
set foldtext=getline(v:foldstart)[0:30].repeat('-',48)
set formatoptions=qljt  "help fo-table
set ignorecase " ignore case
set incsearch " Do incremental searching
set laststatus=0
set linebreak " wrap long lines at a blank
set modeline
set modelines=1
set mouse=a " Only xterm can grab the mouse events when using the shift key
set nohlsearch
set nowrap
set nrformats-=octal " Do not recognize octal numbers for Ctrl-A and Ctrl-x
set pastetoggle=<insert> " key code that causes paste to toggle
set ruler  " show the cursor position all the time
set scrolloff=5 " Show a few lines of context around the cursor
set shiftround " round indent to shiftwidth
set shiftwidth=2 " number of spaces to use for (auto)indent step
set showbreak=+ " hanging indents for wrapped lines set showcmd " show commands
set smartcase " no ignore case when pattern has uppercase
set tabstop=2 " number of spaces that <tab> in file uses
set textwidth=78 " maximum width of text that is being inserted
set ttimeout  " time out for key codes
set ttimeoutlen=100 " wait up to 100ms after Esc for special key
set undodir=~/.vim/undo " undo files here
set undofile " persistent undo
set virtualedit=block
set wildmenu  " display completion matches in a status line

" variables
let mapleader=" "
let maplocalleader=" "
let g:netrw_browsex_viewer="open-link"

" functions
function! OpenLink(parent)
        let l:link = fnamemodify(trim(getline('.')), ':p:h')
    else
        let l:link = fnamemodify(trim(getline('.')), ':p')
    endif

    call system("cygstart" . " " . shellescape(l:link))

    if v:shell_error != 0
        echohl WarningMsg 
        echo "No such file or directory. Are network drives connected?"
        echohl None
    endif

    redraw!

endfunction

function! CenterWindow()
    25vnew
    normal w
    set signcolumn=yes
    set colorcolumn=+3
endfunction

" keymaps
inoremap jk <esc>l
inoremap <nul> <c-x><c-u>
nnoremap // :call FindLine()<cr>
nnoremap <cr> :call OpenLink(0)<cr>
nnoremap  <up> :call OpenLink(1)<cr>
nnoremap <leader>hi :echo synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")<CR>
nnoremap <leader>vi :e $MYVIMRC<cr>
nnoremap <leader>vo :w<cr><c-^>:bdelete .vimrc<cr>:source $MYVIMRC<cr>
nnoremap Y mm0"*y$`m
nnoremap <leader>cw :call CenterWindow()<cr>
vnoremap Y "*y 

" command abbreviations
cnoreabbrev cdd lcd %:p:h<cr>
cnoreabbrev h tab h
cnoreabbrev ee call FindFile()<cr>

" autocommands
 
augroup vimStartup
    autocmd!
    autocmd BufEnter * normal g`"
augroup END

" text
augroup text
    autocmd!
    autocmd FileType text setlocal nowrap
    autocmd FileType text setlocal commentstring=#%s
    autocmd FileType text setlocal textwidth=0
augroup END 


" plugins

" nvim-r
let R_external_term = 'xterm'

function! s:customNvimRMappings()
   nmap <buffer> , <Plug>RSendLine
   vmap <buffer> , <Plug>RDSendSelection
   inoremap <buffer> < <-
   inoremap <buffer> << <
endfunction

augroup myNvimR
   au!
   autocmd filetype r call s:customNvimRMappings()
augroup end

" snipmate
" 'no_match...' for compatibility with mucomplete
let g:snipMate = get(g:, 'snipMate', {
            \ 'always_choose_first' : 1,
            \ 'no_match_completion_feedkeys_chars' : '',
            \ 'snippet_version' : 1,
            \ })
imap <c-l> <Plug>snipMateNextOrTrigger
smap <c-l> <Plug>snipMateNextOrTrigger
smap <c-h> <Plug>snipMateBack
nnoremap <leader>si :e ~/.vim/snippets/_.snippets<cr>
nnoremap <leader>so :w<cr>:bd _.snippets<cr>:SnipMateLoadScope %<cr>
imap <expr> . mucomplete#extend_fwd(".")

