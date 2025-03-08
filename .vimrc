" first thing's first
colorscheme jfin

" define variables
let mapleader = ' '
let maplocalleader = ' '

" other options
set autoread 
set autowriteall
set belloff=all
" set clipboard=unnamedplus
set completeopt=menuone,longest
set encoding=utf-8
set ignorecase 
" set laststatus=3
set mouse=
set pastetoggle=<insert> 
set signcolumn=no
set shellcmdflag='-c'
set shellslash
set shellquote=""
set shellxquote=""
set scrolloff=5
set smartcase 
set undofile 
set virtualedit=block
" set wildmenu
set wildmode=full
set formatoptions=qlcjnr

" dir options
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set undodir=~/.vim/undo 
set viewdir=~/.vim/view

" maps
nnoremap <backspace> :bdelete<cr>
nnoremap <cr> :write<cr>
nnoremap <leader>N viwy/<c-r>"<cr>NN
nnoremap <leader>n viwy/<c-r>"<cr>
nnoremap <leader>w :wincmd w<cr>
nnoremap <silent> <esc> :noh<cr>

nnoremap <esc-j> <c-w><c-w>
tnoremap <esc-j> <c-w><c-w>
tnoremap <esc> <c-\><c-n>
tnoremap <c-j> <c-w>:bn<cr>

" indentation
set autoindent 
set breakindent 
set breakindentopt=shift:0
set expandtab 
set linebreak 
set shiftround 
set shiftwidth=4
set showbreak=+++\ 
set tabstop=4
set textwidth=78 

" folds
set foldlevelstart=0
set foldmethod=marker

" snippets
let g:snipMate = get(g:, 'snipMate', {
            \ 'always_choose_first' : 1,
            \ 'no_match_completion_feedkeys_chars' : '',
            \ })
inoremap <c-l> <Plug>snipMateNextOrTrigger
snoremap <c-l> <Plug>snipMateNextOrTrigger
inoremap <c-h> <Plug>snipMateBack
snoremap <c-h> <Plug>snipMateBack
augroup snipmate
   au!
   autocmd bufleave *.snippets SnipMateLoadScope %
augroup end

" completion
let g:mucomplete#no_mappings = 1
let g:mucomplete#chains = {
    \ 'default' : ['path', 'omni', 'keyp', 'dict', 'uspl']
    \ }

imap <tab> <plug>(MUcompleteFwd)
imap <s-tab> <plug>(MUcompleteBwd)
imap <c-j> <plug>(MUcompleteCycFwd)
imap <c-k> <plug>(MUcompleteCycBwd)
imap <expr> . mucomplete#extend_bwd(".")

" get highlight group
function! GetHighlight()
    let hi    = synIDattr(synID(line('.'), col('.'), 1), 'name')
    let trans = synIDattr(synID(line('.'), col('.'), 0), 'name')
    let lo    = synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    echo 'hi:' . hi . ', trans:' . trans . ', lo:' . lo
endfunction
nnoremap <f10> :call GetHighlight()<cr>

" source updated config files 
augroup vimrc
    au!
    autocmd BufWritePost .vimrc,*/colors/*.vim,*/after/plugin/*.vim source <afile>
augroup end

" clipboard
" set clipboard^=unnamedplus
" let g:clipboard = {
"     \   'name': 'clipboard',
"     \   'copy': {
"     \      '+': "sh -c 'cat > /dev/clipboard'",
"     \      '*': "sh -c 'cat > /dev/clipboard'",
"     \    },
"     \   'paste': {
"     \      '+': "sh -c 'cat /dev/clipboard'",
"     \      '*': "sh -c 'cat /dev/clipboard'",
"     \   },
"     \ }

" fzf
let g:fzf_layout = { 'down': '40%' }
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fl :BLines<cr>
nnoremap <leader>fh :Helptags<cr>
