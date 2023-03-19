" vimrc
syntax enable " enables syntax highlighting, keeping :highlight commands
filetype plugin indent on " enables filetype detection

" options 
set autoindent " take indent for new line from previous line
set autoread " automatically read file when changed outside of vim
set autowriteall " automatically write file if changed
set background=light " 'dark' or 'light' used for highlight colors
set backspace=indent,eol,start " Allow backspacing over everything in insert mode.
set backupdir=~/.vim/backup
set breakindent " wrapped lines are indented same as beginning of line
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
set ruler		" show the cursor position all the time
set scrolloff=5 " Show a few lines of context around the cursor
set shiftround " round indent to shiftwidth
set shiftwidth=4 " number of spaces to use for (auto)indent step
set showbreak=+\ \ \   " hanging indents for wrapped lines set showcmd " show commands
set smartcase " no ignore case when pattern has uppercase
set t_Co=256
set tabstop=4 " number of spaces that <tab> in file uses
set textwidth=78 " maximum width of text that is being inserted
set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key
set undodir=~/.vim/undo " undo files here
set undofile " persistent undo
set virtualedit=block
set wildmenu		" display completion matches in a status line
" set wrapscan

" variables
let mapleader=" "
let g:netrw_browsex_viewer="open-link"

" functions
function! OpenLink(parent)
    " :p make full path
    if a:parent == 1
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
nnoremap <silent> gcc :call nerdcommenter#Comment('n', 'toggle')<CR>
nnoremap Y mm0"*y$`m
nnoremap <leader>cw :call CenterWindow()<cr>
vnoremap Y "*y 
xnoremap <silent> gc :call nerdcommenter#Comment('x', 'toggle')<CR>

" command abbreviations
cnoreabbrev cdd lcd %:p:h<cr>
cnoreabbrev h tab h
cnoreabbrev ee call FindFile()<cr>

" autocommands
 
" Put these in an autocmd group, so that you can revert them with:
" ":augroup vimStartup | au! | augroup END"
augroup vimStartup
    autocmd!

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim) and for a commit message (it's
" likely a different one than last time).
    autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ |   exe "normal! g`\""
        \ | endif

augroup END

" ide
augroup ide
    autocmd!
    autocmd FileType python,r,sh,scheme nnoremap <buffer> <leader>ri 
                \:call system("open-repl " . &filetype)<cr>
    autocmd FileType python,r let b:SuperTabContextDefaultCompletionType = "<c-x><c-u>"
augroup END

" r
augroup r 
    autocmd!
    autocmd FileType r inoremap <buffer> < <-
    autocmd FileType r inoremap <buffer> << <
    autocmd FileType r nnoremap K :execute 'SlimeSend1 help('.expand('<cword>').')'<cr>
    autocmd FileType r nnoremap <leader>ro :execute 'SlimeSend1 q()'<cr>
augroup END 

" sh
augroup sh
    autocmd!
    autocmd FileType sh setlocal noexpandtab
augroup END 

" markdown
augroup markdown 
    autocmd!
    " autocmd FileType markdown set nowrap
    " autocmd FileType markdown let markdown_folding = 1
    " autocmd FileType markdown setlocal conceallevel=2
    " autocmd FileType markdown setlocal textwidth=0
augroup END 

" text
augroup text
    autocmd!
    " autocmd FileType text setlocal nowrap
    autocmd FileType text setlocal commentstring=#%s
    autocmd FileType text setlocal textwidth=0
augroup END 

" plugins

" slime
let g:slime_target = "tmux"
let g:slime_default_config = {
            \ "socket_name": "default", 
            \ "target_pane": "{bottom-right}",
            \}
let g:slime_dont_ask_default = 1
augroup slimerc
    autocmd!
    autocmd FileType python,r,scheme,sh nmap <buffer> , <Plug>SlimeLineSend
    autocmd FileType python,r,scheme,sh xmap <buffer> , <Plug>SlimeRegionSend'>
augroup END

" snipmate
" 'no_match...' for compatibility with mucomplete
let g:snipMate = get(g:, 'snipMate', {
            \ 'always_choose_first' : 1,
            \ 'no_match_completion_feedkeys_chars' : '',
            \ 'snippet_version' : 1,
            \ })
imap <c-l> <Plug>snipMateNextOrTrigger
smap <c-l> <Plug>snipMateNextOrTrigger
" imap <c-h> <Plug>snipMateBack
smap <c-h> <Plug>snipMateBack
nnoremap <leader>si :e ~/.vim/snippets/_.snippets<cr>
nnoremap <leader>so :w<cr>:bd _.snippets<cr>:SnipMateLoadScope %<cr>
imap <expr> . mucomplete#extend_fwd(".")

" nerd commenter
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

" lsc
let g:lsc_auto_map = {'defaults': v:true, 'ShowHover': ''}
let g:lsc_enable_autocomplete = v:false
let g:lsc_enable_diagnostics = v:false
let g:lsc_reference_highlights = v:false
let g:lsc_server_commands = { 
            \ 'r': 'R --slave -e languageserver::run()',
            \ }

" mucomplete
let g:mucomplete#always_use_completeopt = 0
" c-n  c-p  cmd  defs dict file incl keyn keyp line omni
" spel tags thes user path uspl list nsnp snip ulti
let g:mucomplete#chains = {
    \ 'default' : ['uspl', 'path', 'user', 'keyn', 'snip'],
    \ }

" Colors
" black    darkred darkgreen brown  darkblue darkmagenta darkcyan lightgray
" darkgray red     green     yellow blue     magenta     cyan     white
" highlight conceal
" highlight cursorcolumn
" highlight cursorline
" highlight cursorlinenr
" highlight directory
" highlight foldcolumn
" highlight linenr            ctermfg=darkgray  ctermbg=white   cterm=none
" highlight linenrabove
" highlight linenrbelow
" highlight modemsg
" highlight moremsg
" highlight question
" highlight quickfixline
" highlight warningmsg
highlight  colorcolumn      ctermfg=none     ctermbg=lightgray cterm=none
highlight  comment          ctermfg=darkgray  ctermbg=none      cterm=none
highlight  constant         ctermfg=darkcyan  ctermbg=none      cterm=none
highlight  diffadd          ctermfg=darkgreen ctermbg=none      cterm=none
highlight  diffchange       ctermfg=black     ctermbg=none      cterm=none
highlight  diffdelete       ctermfg=red       ctermbg=none      cterm=none
highlight  difftext         ctermfg=darkcyan  ctermbg=none      cterm=none
highlight  endofbuffer      ctermfg=darkgray  ctermbg=none      cterm=none
highlight  error            ctermfg=red       ctermbg=none      cterm=none
highlight  errormsg         ctermfg=red       ctermbg=none      cterm=none
highlight  folded           ctermfg=darkgray  ctermbg=none      cterm=none
" highlight  htmlItalic       ctermfg=black     ctermbg=yellow    cterm=none
highlight  identifier       ctermfg=black     ctermbg=none      cterm=none
highlight  ignore           ctermfg=black     ctermbg=none      cterm=none
highlight  incsearch        ctermfg=black     ctermbg=yellow    cterm=none
highlight  matchparen       ctermfg=black     ctermbg=yellow    cterm=none
highlight  nontext          ctermfg=darkgray  ctermbg=none      cterm=none
highlight  pmenu            ctermfg=black     ctermbg=lightgray cterm=none
highlight  pmenusbar        ctermfg=none      ctermbg=lightgray cterm=none
highlight  pmenusel         ctermfg=black     ctermbg=yellow    cterm=none
highlight  pmenuthumb       ctermfg=none      ctermbg=darkgray  cterm=none
highlight  preproc          ctermfg=black     ctermbg=none      cterm=none
highlight  search           ctermfg=black     ctermbg=yellow    cterm=none
highlight  signcolumn       ctermfg=white     ctermbg=none      cterm=none
highlight  special          ctermfg=black     ctermbg=none      cterm=none
highlight  specialkey       ctermfg=darkgray  ctermbg=none      cterm=none
highlight  spellbad         ctermfg=red       ctermbg=none      cterm=none
highlight  spellcap         ctermfg=red       ctermbg=none      cterm=none
highlight  spelllocal       ctermfg=red       ctermbg=none      cterm=none
highlight  spellrare        ctermfg=red       ctermbg=none      cterm=none
highlight  statement        ctermfg=black     ctermbg=none      cterm=none
highlight  statusline       ctermfg=darkgray  ctermbg=lightgray     cterm=none
highlight  statuslinenc     ctermfg=darkgray  ctermbg=lightgray     cterm=none
highlight  statuslineterm   ctermfg=darkgray  ctermbg=lightgray     cterm=none
highlight  statuslinetermnc ctermfg=darkgray     ctermbg=lightgray     cterm=none
highlight  tabline          ctermfg=darkgray  ctermbg=lightgray cterm=none
highlight  tablinefill      ctermfg=darkgray  ctermbg=lightgray cterm=none
highlight  tablinesel       ctermfg=darkgray  ctermbg=none      cterm=none
highlight  title            ctermfg=black     ctermbg=none      cterm=none
highlight  todo             ctermfg=black     ctermbg=none    cterm=none
highlight  type             ctermfg=black     ctermbg=none      cterm=none
highlight  underlined       ctermfg=black     ctermbg=none      cterm=underline
highlight  vertsplit        ctermfg=none      ctermbg=lightgray cterm=none
highlight  visual           ctermfg=black     ctermbg=yellow cterm=none
highlight  visualnos        ctermfg=black     ctermbg=yellow    cterm=none
highlight  wildmenu         ctermfg=black     ctermbg=yellow    cterm=none
