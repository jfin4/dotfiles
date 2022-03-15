"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   vimrc                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable " enables syntax highlighting, keeping :highlight commands
filetype plugin indent on " enables filetype detection

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  options                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set autoindent " take indent for new line from previous line
set autoread " automatically read file when changed outside of vim
set autowriteall " automatically write file if changed
set background=light " 'dark' or 'light' used for highlight colors
set backspace=indent,eol,start " Allow backspacing over everything in insert mode.
set backupdir=~/.vim/backup
set breakindent " wrapped lines are indented same as beginning of line
set directory=~/.vim/swap
set display=lastline " Show @@@ in the last line if it is truncated.
set encoding=utf-8
set expandtab " use spaces when <tab> is inserted
set fillchars=vert:\ ,fold:\ ,eob:\ 
set foldtext=getline(v:foldstart).'...'
set foldlevel=99
set foldmethod=indent
set formatoptions=qnlj  "help fo-table
set ignorecase " ignore case
set incsearch " Do incremental searching
set laststatus=0
set linebreak " wrap long lines at a blank
set modeline
set modelines=1
set mouse=a " Only xterm can grab the mouse events when using the shift key
set nohlsearch
set wrapscan
set nrformats-=octal " Do not recognize octal numbers for Ctrl-A and Ctrl-x
set pastetoggle=<insert> " key code that causes paste to toggle
set ruler		" show the cursor position all the time
set scrolloff=5 " Show a few lines of context around the cursor
set shiftround " round indent to shiftwidth
set shiftwidth=4 " number of spaces to use for (auto)indent step
set signcolumn=yes
set showbreak=\|\ \ \   " hanging indents for wrapped lines
set showcmd " show commands
set smartcase " no ignore case when pattern has uppercase
set t_Co=256
set tabstop=4 " number of spaces that <tab> in file uses
set textwidth=0 " maximum width of text that is being inserted
set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key
set undodir=~/.vim/undo " undo files here
set undofile " persistent undo
set virtualedit=block
set wildmenu		" display completion matches in a status line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 variables                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=" "
let g:netrw_browsex_viewer="open-link"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 functions                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! FindLine()
    write
    try
        let output = system("grep --ignore-case . " . expand("%") . " | fzy | tr -d '\n'")
    catch /Vim:Interrupt/
        " Swallow errors from ^C, allow redraw! below
    endtry
    redraw!
    if v:shell_error == 0 && !empty(output)
        exec "/" . output
    endif
endfunction

function! FindFile()
    try
        let output = system("find . -type f | fzy")
    catch /Vim:Interrupt/
        " Swallow errors from ^C, allow redraw! below
    endtry
    redraw!
    if v:shell_error == 0 && !empty(output)
        exec "e " . output
    endif
endfunction

function! OpenLink()
    " :p make full path
    let l:link = fnamemodify(trim(getline('.')), ':p')
    if l:link[0:4] == '/home'
        exec "e" l:link
    else
        call system("cygstart" . " " . shellescape(l:link))
        if v:shell_error != 0
            echohl WarningMsg 
            echo "No such file or directory. Are network drives connected?"
            echohl None
        endif
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  keymaps                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

inoremap jk <esc>l
nnoremap <cr> :call OpenLink()<cr>
nnoremap <leader>e :call FindFile()<cr>
nnoremap <leader>hi :echo synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")<CR>
nnoremap <leader>/ :call FindLine()<cr>
nnoremap <leader>si :e ~/.vim/snippets-jfin/
nnoremap <leader>so <c-^>:bdelete snippets<cr>:call UltiSnips#RefreshSnippets()<cr>
nnoremap <leader>vi :e $MYVIMRC<cr>
nnoremap <leader>vo :w<cr><c-^>:bdelete .vimrc<cr>:source $MYVIMRC<cr>
nnoremap Y mm0"*y$`m
vnoremap Y "*y

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           command abbreviations                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

cnoreabbrev cdd lcd %:p:h
cnoreabbrev h tab h

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                autocommands                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" program
augroup program
    autocmd!
    autocmd FileType julia,python,r,sh setlocal textwidth=78
    autocmd FileType julia,python,r,sh nnoremap <buffer> <leader>ro 
                \:silent !open-repl close<cr>
                \:redraw!<cr>
    autocmd FileType julia,python,r,sh nmap <buffer> , 
                \<Plug>SlimeLineSend/^[^#\$]<cr>
    autocmd FileType julia,python,r,sh xmap <buffer> , 
                \<Plug>SlimeRegionSend
    autocmd FileType julia,python,r,sh nmap <buffer> <leader>, 
                \<Plug>SlimeParagraphSend}j
    autocmd FileType julia,python,r,sh nnoremap <buffer> K 
                \viw"ry:SlimeSend1 help(<c-r>r)<cr>
augroup END

" julia
augroup julia 
  autocmd!
  autocmd FileType julia nnoremap <buffer> <leader>ri :silent !open-repl julia<cr>
augroup END 

" r
augroup r 
  autocmd!
  autocmd FileType r inoremap <buffer> < <-
  autocmd FileType r inoremap <buffer> << <
  autocmd FileType r nnoremap <buffer> <leader>ri :silent !open-repl run-r<cr>
augroup END 

" sh
augroup sh
    autocmd!
    autocmd FileType sh nnoremap <buffer> <leader>ri :silent !open-repl<cr>
augroup END 

" python
augroup python
    autocmd!
    autocmd FileType python nnoremap <buffer> <leader>ri :silent !open-repl python<cr>
augroup END 

" markdown
augroup markdown 
  autocmd!
  autocmd FileType markdown let markdown_folding = 1
  autocmd FileType markdown setlocal conceallevel=2
augroup END 

" csv
augroup csv
  autocmd!
  autocmd BufRead,BufNew *.csv set filetype=csv
  autocmd FileType csv set commentstring=#%s
  autocmd FileType csv set nowrap
augroup END 

" text
augroup text
  autocmd!
  autocmd FileType text set nowrap
augroup END 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  plugins                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{bottom-right}"}
let g:slime_dont_ask_default = 1

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=[ "snippets-jfin", "Ultisnips" ]

" supertab
let g:SuperTabDefaultCompletionType = 'context'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   colors                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NR-16   NR-8   COLOR NAME
" 0       0      Black
" 8       0*     DarkGray, DarkGrey
" 1       4      DarkBlue
" 9       4*     Blue, LightBlue
" 2       2      DarkGreen
" 10      2*     Green, LightGreen
" 3       6      DarkCyan
" 11      6*     Cyan, LightCyan
" 4       1      DarkRed
" 12      1*     Red, LightRed
" 5       5      DarkMagenta
" 13      5*     Magenta, LightMagenta
" 14      3*     Yellow, LightYellow
" 6       3      Brown, DarkYellow
" 7       7      LightGray, LightGrey, Gray, Grey
" 15      7*     White

highlight  comment          ctermfg=darkgray  ctermbg=none      cterm=none
highlight  constant         ctermfg=darkcyan  ctermbg=none      cterm=none
highlight  identifier       ctermfg=black     ctermbg=none      cterm=none
highlight  statement        ctermfg=black     ctermbg=none      cterm=none
highlight  preproc          ctermfg=black     ctermbg=none      cterm=none
highlight  type             ctermfg=black     ctermbg=none      cterm=none
highlight  special          ctermfg=black     ctermbg=none      cterm=none
highlight  underlined       ctermfg=black     ctermbg=none      cterm=underline
highlight  ignore           ctermfg=black     ctermbg=none      cterm=none
highlight  error            ctermfg=red       ctermbg=none      cterm=none
highlight  todo             ctermfg=black     ctermbg=yellow    cterm=none
highlight  colorcolumn      ctermfg=black     ctermbg=lightgray cterm=none
"highlight conceal
"highlight cursorcolumn
"highlight cursorline
"highlight cursorlinenr
highlight  diffadd          ctermfg=darkgreen ctermbg=none      cterm=none
highlight  diffchange       ctermfg=black     ctermbg=none      cterm=none
highlight  diffdelete       ctermfg=red       ctermbg=none      cterm=none
highlight  difftext         ctermfg=darkcyan  ctermbg=none      cterm=none
"highlight directory
highlight  endofbuffer      ctermfg=darkgray  ctermbg=none      cterm=none
highlight  errormsg         ctermfg=red       ctermbg=none      cterm=none
"highlight foldcolumn
highlight  folded           ctermfg=darkgray  ctermbg=none      cterm=none
highlight  incsearch        ctermfg=black     ctermbg=yellow    cterm=none
"          highlight        linenr            ctermfg=darkgray  ctermbg=white   cterm=none
"highlight linenrabove
"highlight linenrbelow
"highlight modemsg
"highlight moremsg
highlight  nontext          ctermfg=darkgray  ctermbg=none      cterm=none
highlight  pmenu            ctermfg=black     ctermbg=lightgray cterm=none
highlight  pmenusbar        ctermfg=none      ctermbg=lightgray cterm=none
highlight  pmenusel         ctermfg=black     ctermbg=yellow    cterm=none
highlight  pmenuthumb       ctermfg=none      ctermbg=darkgray  cterm=none
"highlight question
"highlight quickfixline
highlight  search           ctermfg=black     ctermbg=yellow    cterm=none
highlight  signcolumn       ctermfg=white     ctermbg=none      cterm=none
highlight  specialkey       ctermfg=darkgray  ctermbg=none      cterm=none
highlight  spellbad         ctermfg=red       ctermbg=none      cterm=none
highlight  spellcap         ctermfg=red       ctermbg=none      cterm=none
highlight  spelllocal       ctermfg=red       ctermbg=none      cterm=none
highlight  spellrare        ctermfg=red       ctermbg=none      cterm=none
highlight  statusline       ctermfg=darkgray  ctermbg=white     cterm=none
highlight  statuslinenc     ctermfg=white     ctermbg=white     cterm=none
highlight  statuslineterm   ctermfg=darkgray  ctermbg=white     cterm=none
highlight  statuslinetermnc ctermfg=white     ctermbg=white     cterm=none
highlight  tabline          ctermfg=darkgray  ctermbg=lightgray cterm=none
highlight  tablinefill      ctermfg=darkgray  ctermbg=lightgray cterm=none
highlight  tablinesel       ctermfg=darkgray  ctermbg=none      cterm=none
highlight  title            ctermfg=black     ctermbg=none      cterm=none
"highlight vertsplit
highlight  visual           ctermfg=black     ctermbg=yellow cterm=none
highlight  visualnos        ctermfg=black     ctermbg=yellow    cterm=none
"highlight warningmsg
highlight  wildmenu         ctermfg=black     ctermbg=yellow    cterm=none
highlight  htmlItalic       ctermfg=black     ctermbg=yellow    cterm=none
highlight  matchparen       ctermfg=black     ctermbg=yellow    cterm=none

