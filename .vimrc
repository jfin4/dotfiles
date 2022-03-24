" vimrc
syntax enable " enables syntax highlighting, keeping :highlight commands
filetype plugin indent on " enables filetype detection

" options
set autoindent " take indent for new line from previous line
set autoread " automatically read file when changed outside of vim
set autowriteall " automatically write file if changed
set background=light " 'dark' or 'light' used for highlight colors
set backspace=indent,eol,start " Allow backspacing over everything in insert mode.
set breakindent " wrapped lines are indented same as beginning of line
set completeopt=menu,menuone,noinsert
set display=lastline " Show @@@ in the last line if it is truncated.
set encoding=utf-8
set expandtab " use spaces when <tab> is inserted
set fillchars=vert:\ ,fold:\ ,eob:\ 
set foldlevel=99
set foldmethod=indent
set foldtext=getline(v:foldstart).'...'
set formatoptions=qnlj  "help fo-table
set ignorecase " ignore case
set incsearch " Do incremental searching
set laststatus=0
set linebreak " wrap long lines at a blank
set modeline
set modelines=1
set mouse=a " Only xterm can grab the mouse events when using the shift key
set nohlsearch
set nrformats-=octal " Do not recognize octal numbers for Ctrl-A and Ctrl-X
set pastetoggle=<insert> " key code that causes paste to toggle
set ruler		" show the cursor position all the time
set scrolloff=5 " Show a few lines of context around the cursor
set shiftround " round indent to shiftwidth
set shiftwidth=4 " number of spaces to use for (auto)indent step
set showbreak=\|\ \ \  
set showcmd " show commands
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
set wrapscan

" variables
let mapleader = " "

" functions

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
        call system("xdg-open" . " " . shellescape(l:link))
        if v:shell_error != 0
            echohl WarningMsg 
            echo "No such file or directory. Are network drives connected?"
            echohl None
        endif
    endif
endfunction

" keymaps
inoremap jk <esc>l
nnoremap // :call FindLine()<cr>
nnoremap <cr>:call OpenLink()<cr>
nnoremap <leader>hi :echo synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")<CR>
nnoremap <leader>si :e ~/.vim/snippets-jfin/
nnoremap <leader>so <c-^>:bdelete snippets<cr> \ :call UltiSnips#RefreshSnippets()<cr>
nnoremap <leader>vi :e $MYVIMRC<cr>
nnoremap <leader>vo :w<cr><c-^>:bdelete .vimrc<cr>:source $MYVIMRC<cr>
nnoremap <silent> gcc :call nerdcommenter#Comment('n', 'toggle')<CR>
vnoremap Y "+y
xnoremap <silent> gc :call nerdcommenter#Comment('x', 'toggle')<CR>


" command abbreviations
cnoreabbrev cdd lcd %:p:h
cnoreabbrev h tab h
cnoreabbrev ee call FindFile()


" autocommands

" ide
augroup ide
    autocmd!
    autocmd FileType python,r,sh nnoremap <buffer> <leader>ri 
                \:call system("open-repl " . &filetype)<cr>
augroup END

" r
augroup r 
    autocmd!
    autocmd FileType r inoremap <buffer> < <-
    autocmd FileType r inoremap <buffer> << <
augroup END 

" sh
augroup sh
    autocmd!
    autocmd FileType sh setlocal noexpandtab
augroup END 

" markdown
augroup markdown 
    autocmd!
    autocmd FileType markdown let markdown_folding = 1
    autocmd FileType markdown setlocal conceallevel=2
    autocmd FileType markdown setlocal textwidth=0
augroup END 

" text
augroup text
    autocmd!
    autocmd FileType text setlocal nowrap
    autocmd FileType text setlocal commentstring=#%s
    autocmd FileType text setlocal textwidth=0
augroup END 

" plugins

" slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{bottom-right}"}
let g:slime_dont_ask_default = 1
augroup slimerc
    autocmd!
    autocmd FileType python,r,sh nmap <buffer> , <Plug>SlimeLineSend/^[^#\$]<cr>
    autocmd FileType python,r,sh xmap <buffer> , <Plug>SlimeRegionSend
augroup END

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=[ "snippets-jfin", "Ultisnips" ]

" nerd commenter
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

" vim lsc
let g:lsc_auto_map = v:true
let g:lsc_enable_autocomplete = v:false
let g:lsc_enable_diagnostics = v:false
let g:lsc_hover_popup = v:false
let g:lsc_reference_highlights = v:false
let g:lsc_server_commands = { 'r': 'R --slave -e languageserver::run()' }
let g:lsc_trace_level = 'off'

" supertab
let g:SuperTabDefaultCompletionType = "context"
augroup slime
    autocmd!
    autocmd FileType python,r,sh let b:SuperTabNoCompleteAfter = ['^']
    autocmd FileType python,r,sh let b:SuperTabContextDefaultCompletionType = "<c-x><c-u>"
augroup END

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
" highlight vertsplit
" highlight warningmsg
highlight  colorcolumn      ctermfg=black     ctermbg=lightgray cterm=none
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
highlight  htmlItalic       ctermfg=black     ctermbg=yellow    cterm=none
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
highlight  todo             ctermfg=black     ctermbg=yellow    cterm=none
highlight  type             ctermfg=black     ctermbg=none      cterm=none
highlight  underlined       ctermfg=black     ctermbg=none      cterm=underline
highlight  visual           ctermfg=black     ctermbg=yellow cterm=none
highlight  visualnos        ctermfg=black     ctermbg=yellow    cterm=none
highlight  wildmenu         ctermfg=black     ctermbg=yellow    cterm=none
