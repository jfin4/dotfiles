filetype plugin indent on 
syntax enable 
colorscheme jfin
" set options
set autoindent " take indent for new line from previous line
set autoread " automatically read file when changed outside of vim
set autowrite " automatically write file if changed
set backspace=indent,eol,start " how backspace works at start of line
set breakindent " wrapped lines are indented same as beginning of line
set complete=.,w,b,u,t,i,k " added k for dictionary search
set directory=. " where to put .swp
set encoding=utf-8
set expandtab " use spaces when <tab> is inserted
set foldmethod=marker " folding type
set formatoptions=tcqrj
set nohlsearch
set ignorecase " ignore case
set incsearch
set laststatus=2
set linebreak " wrap long lines at a blank
set modeline
set modelines=1
set nowrapscan
set number " print the line number in front of each line
set pastetoggle=<insert> " key code that causes paste to toggle
set ruler " show cursor line and column in the status line
set shiftround " round indent to shiftwidth
" set shiftwidth=4 " number of spaces to use for (auto)indent step
set showbreak=+\  " hanging indents for wrapped lines
set showcmd " show commands
set smartcase " no ignore case when pattern has uppercase
" set tabstop=4 " number of spaces that <tab> in file uses
set tags=./tags;
set textwidth=78 " maximum width of text that is being inserted
set undodir=~/.vim/undo " undo files here
set undofile " persistent undo
set virtualedit=block
set wildmenu
" define variables
let mapleader=" "
" let markdown_folding = 1
" define maps
inoremap jk <esc>l
nnoremap <leader>w :w<cr>
nnoremap <leader>j :bnext<cr>
nnoremap <c-j> :bnext<cr>
nnoremap <leader>k :bprevious<cr>
nnoremap <f10>
    \ :echo synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")<CR>
nnoremap <leader>d :bnext<cr>:bdelete #<cr>
nnoremap <leader>vi :e $MYVIMRC<cr>
nnoremap <leader>vo :source $MYVIMRC<cr>
noremap Y "+y
nnoremap <leader>f :<C-U>RangerChooser<CR>
" filetype specific
" html
augroup html
    autocmd!
    autocmd FileType html setlocal tabstop=2 
    autocmd FileType html setlocal shiftwidth=2 
augroup END 
" markdown
augroup markdown 
    autocmd!
    autocmd FileType markdown set commentstring=<!--%s-->
    autocmd FileType markdown set foldlevel=2 
    autocmd FileType markdown set formatoptions-=t
    autocmd FileType markdown set textwidth=0 
    autocmd FileType markdown set nowrap
    " autocmd FileType markdown set concealcursor=nc
    autocmd FileType markdown set conceallevel=2
    " may eventually move to .vim/after/syntax/markdown.vim >>>>>>>
    autocmd FileType markdown syn region markdownLinkText 
                \ matchgroup=markdownLinkTextDelimiter
                \ start="!\=\[\%(\_[^]]*]\%( \=[[(]\)\)\@=" 
                \ end="\]\%( \=[[(]\)\@="
                \ nextgroup=markdownLink,markdownId 
                \ skipwhite
                \ contains=@markdownInline,markdownLineStart
                \ concealends
    autocmd FileType markdown syn region markdownLink 
                \ matchgroup=markdownLinkDelimiter 
                \ start="(" 
                \ end=")" 
                \ contains=markdownUrl 
                \ keepend 
                \ contained
                \ conceal
    " <<<<<<<
augroup END 
" python
augroup python
    autocmd!
    autocmd FileType python nnoremap <buffer><leader>ri :!py-pane<cr>
    autocmd FileType python nnoremap <buffer><leader>ro :!tmux kill-pane -t {bottom-right}<cr>
augroup END 
" r
augroup r 
    autocmd!
    autocmd FileType r inoremap <buffer> < <-
    autocmd FileType r inoremap <buffer> << <
    autocmd FileType r nnoremap <buffer><silent> K viw"ry:SlimeSend1 help(<c-r>r)<cr>
    autocmd FileType r nnoremap <buffer><silent> <leader>vv 
        \ viw"ey:w<cr>:SlimeSend1 sink("/tmp/<c-r>e"); <c-r>e; sink()<cr>:e /tmp/<c-r>e<cr>
    autocmd FileType r nnoremap <buffer><leader>ri :!r-pane<cr>
    autocmd FileType r nnoremap <buffer><leader>ro :!tmux kill-pane -t {bottom-right}<cr>
augroup END 
" sh
augroup sh 
    autocmd!
    autocmd FileType sh setlocal noexpandtab
    autocmd FileType sh nnoremap <buffer><leader>ri :!sh-pane<cr>
    autocmd FileType sh nnoremap <buffer><leader>ro :!tmux kill-pane -t {bottom-right}<cr>
augroup END
" vimrc
augroup folds
  autocmd!
  autocmd BufWinLeave .vimrc mkview
  autocmd BufWinEnter .vimrc silent! loadview
augroup END
" configure plugins
" slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{bottom-right}"}
let g:slime_dont_ask_default = 1
let g:slime_python_ipython = 1
augroup slime 
    autocmd!
    autocmd FileType python,r,sh nmap <buffer> , <Plug>SlimeLineSend/^[^#\$]<cr>
    autocmd FileType python,r,sh xmap <buffer> , <Plug>SlimeRegionSend
    autocmd FileType python,r,sh nmap <buffer> <leader>, <Plug>SlimeParagraphSend}j
augroup END 
" ultisnips
let g:UltiSnipsSnippetDirectories = ["/home/jfin/.vim/snippets-jfin/","UltiSnips"]
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"vim wiki
  let g:vimwiki_list = [{'path': '~/notes/', 'syntax': 'markdown', 'ext': '.txt'}]

" vim: foldmethod=manual
