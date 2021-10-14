""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
set breakindentopt=shift:2
set directory=~/.vim/swap
set display=lastline " Show @@@ in the last line if it is truncated.
set encoding=utf-8
set expandtab " use spaces when <tab> is inserted
set fillchars=vert:\ ,fold:\ ,eob:\ 
set foldtext=getline(v:foldstart).'...'
set ignorecase " ignore case
set incsearch " Do incremental searching
set laststatus=0
set linebreak " wrap long lines at a blank
set modeline
set modelines=1
set mouse=a " Only xterm can grab the mouse events when using the shift key
set nohlsearch
set nowrapscan
set nrformats-=octal " Do not recognize octal numbers for Ctrl-A and Ctrl-X
set pastetoggle=<insert> " key code that causes paste to toggle
set ruler		" show the cursor position all the time
set scrolloff=5 " Show a few lines of context around the cursor
set shiftround " round indent to shiftwidth
set shiftwidth=2 " number of spaces to use for (auto)indent step
set signcolumn=yes
set showbreak=+\  " hanging indents for wrapped lines
set showcmd " show commands
set smartcase " no ignore case when pattern has uppercase
set t_Co=256
set tabstop=2 " number of spaces that <tab> in file uses
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

let mapleader = " "

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 functions                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! FzySearchLine()
    call inputsave()
    let l:pat = input('//')
    call inputrestore()

    if l:pat == ''
        let l:pat = '.'
    endif

    " Swallow errors from ^C, allow redraw! below
    try
        let output = system('grep -n ' . l:pat . ' ' . expand('%') . ' | fzy')
        let pos = match(output, ":")
        let lnum = output[0:pos - 1]
    catch /Vim:Interrupt/
    endtry

    redraw!

    if v:shell_error == 0 && !empty(output)
        call cursor(lnum, 1)
    endif
endfunction

function! OpenREPL(repl)
    call system('tmux split-window -h -c "#{pane_current_path}" '
        \ . a:repl
        \ . ' \; '
        \ . 'move-pane -t {bottom-right} \; '
        \ . 'select-layout main-vertical \; '
        \ . 'select-pane -t {last}')
endfunction

function! CloseREPL()
    call system("tmux kill-pane -t {bottom-right}")
endfunction

function! OpenFile()
    let line = getline('.')
    let link = fnamemodify(line, ':p')
    let ext = fnamemodify(link, ':e')

    if ext[0:2] == 'txt' || ext[0:1] == 'md' || ext[0:2] == 'csv'
        call system("tmux split-window -b vim " 
            \ . link 
            \ . " && tmux select-layout main-vertical")
    elseif link[0:3] == 'http'
        call system("firefox '" . link . "' &")
    elseif ext == 'pdf'
        call system("sumatraPDF '" . link . "' &")
    else 
        call system("cygstart '" . link . "' &")
    endif
endfunction

function! OpenDir()
  let link = fnamemodify(@d, ':p:h')
  if link[0:2] == '/r/' || link[0:2] == '/h/'
      call system("cygstart '" . link . "' &")
  else
      call system("tmux split-window -bc '" 
            \ . link 
            \ . "'; tmux select-layout main-vertical")
  endif
endfunction

function! CopyPath()
  let line = getline('.')
  let @* = system('cygpath -u "' . line . '"')[:-2]
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  keymaps                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap // :call FzySearchLine()<cr>
nnoremap <cr> :call OpenFile()<cr>
inoremap jk <esc>l
nnoremap <leader>hi
      \ :echo synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")<CR>
nnoremap <leader>si :e ~/.vim/snippets-jfin/
nnoremap <leader>so <c-^>:bdelete snippets<cr>
      \ :call UltiSnips#RefreshSnippets()<cr>
nnoremap <leader>vi :e $MYVIMRC<cr>
nnoremap <leader>vo :w<cr><c-^>:bdelete .vimrc<cr>:source $MYVIMRC<cr>
vnoremap Y "*y
nnoremap Y :call CopyPath()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           command abbreviations                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

cnoreabbrev cdd lcd %:p:h
cnoreabbrev h tab h

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                autocommands                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" softwrap
augroup softwrap
  autocmd!
  autocmd VimResized * if (&columns > 80) | set columns=80 | endif
augroup END

" text
augroup text
  autocmd!
  autocmd FileType text setlocal foldmethod=indent
  autocmd FileType text setlocal shiftwidth=2 tabstop=2
  autocmd FileType text setlocal formatoptions-=t textwidth=0
augroup END

" r
augroup r 
  autocmd!
  autocmd FileType r inoremap <buffer> < <-
  autocmd FileType r inoremap <buffer> << <
  autocmd FileType r nnoremap <buffer> <leader>ri :call OpenREPL('wrap-r')<cr>
  autocmd FileType r nnoremap <buffer> <leader>ro :call CloseREPL()<cr>
  autocmd FileType r nmap <buffer> , <Plug>SlimeLineSend/^[^#\$]<cr>
  autocmd FileType r xmap <buffer> , <Plug>SlimeRegionSend
  autocmd FileType r nmap <buffer> <leader>, <Plug>SlimeParagraphSend}j
  autocmd FileType r nnoremap <buffer> K viw"ry:SlimeSend1 help(<c-r>r)<cr>
augroup END 

" sh
augroup sh 
  autocmd!
  autocmd FileType sh setlocal noexpandtab
  autocmd FileType sh nnoremap <buffer> <leader>ri :call OpenREPL('ksh')<cr>
  autocmd FileType sh nnoremap <buffer> <leader>ro :call CloseREPL()<cr>
  autocmd FileType sh nmap <buffer> , <Plug>SlimeLineSend/^[^#\$]<cr>
  autocmd FileType sh xmap <buffer> , <Plug>SlimeRegionSend
  autocmd FileType sh nmap <buffer> <leader>, <Plug>SlimeParagraphSend}j
augroup END

" markdown
augroup markdown 
  autocmd!
  autocmd FileType markdown let markdown_folding = 1
  autocmd FileType markdown setlocal formatoptions-=t nowrap textwidth=0
  autocmd FileType markdown setlocal conceallevel=2
  autocmd FileType markdown setlocal foldlevel=2 
augroup END 

" csv
augroup csv
  autocmd!
  autocmd FileType csv set commentstring=#%s
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
highlight  visual           ctermfg=black     ctermbg=lightgray cterm=none
highlight  visualnos        ctermfg=black     ctermbg=yellow    cterm=none
"highlight warningmsg
highlight  wildmenu         ctermfg=black     ctermbg=yellow    cterm=none
highlight  htmlItalic       ctermfg=black     ctermbg=yellow    cterm=none
highlight  matchparen       ctermfg=black     ctermbg=yellow    cterm=none

