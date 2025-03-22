" first thing's first
syntax on
filetype indent on
filetype plugin on
colorscheme jfin

" define variables
let mapleader = ' '
let maplocalleader = ' '

" other options
set autoread 
set autowriteall
set belloff=all
set completeopt=menuone,longest
set encoding=utf-8
set ignorecase 
set mouse=
set pastetoggle=<insert> 
set signcolumn=no
set scrolloff=5
set smartcase 
set undofile 
set virtualedit=block
set wildmenu
set wildmode=full
set formatoptions=qlcjnr

" dir options
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set undodir=~/.vim/undo 
set viewdir=~/.vim/view

" maps
nnoremap <cr> :write<cr>
nnoremap <silent> <esc> :noh<cr>
tnoremap <esc><esc> <c-\><c-n>
tnoremap :: <c-w>:

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
    \ 'default' : ['path', 'omni', 'keyp', 'dict', 'uspl'],
    \ 'r' : ['path', 'omni', 'keyn', 'dict', 'uspl']
    \ }

imap <tab> <plug>(MUcompleteFwd)
imap <s-tab> <plug>(MUcompleteBwd)
imap <c-space> <plug>(MUcompleteCycFwd)
imap <expr> . mucomplete#extend_bwd(".")

" get highlight group
function! GetHighlight()
    let hi    = synIDattr(synID(line('.'), col('.'), 1), 'name')
    let trans = synIDattr(synID(line('.'), col('.'), 0), 'name')
    let lo    = synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    echo 'hi:' . hi . ', trans:' . trans . ', lo:' . lo
endfunction

" source updated config files 
augroup vimrc
    au!
    autocmd BufWritePost .vimrc,*/colors/*.vim,*/plugin/*.vim source <afile>
augroup end

" fzf
let g:fzf_colors = { 'border':  ['fg', 'vertsplit'] }

"lsp
let g:lsp_diagnostics_enabled = 0
let g:lsp_settings_enable_suggestions = 0
let g:lsp_completion_documentation_enabled = 0
let g:lsp_signature_help_enabled = 0
set omnifunc=lsp#complete
inoremap <c-h> <c-o><plug>(lsp-signature-help)
