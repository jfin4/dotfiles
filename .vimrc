" vim: set ft=vim :
filetype indent plugin on
syntax on
colorscheme jfin

" variables
let mapleader = ' '
let maplocalleader = ' '

" settings
source $VIMRUNTIME/defaults.vim

set backupdir=~/.vim/backup
set directory=~/.vim/swap
set undodir=~/.vim/undo 
set viewdir=c:/msys64/home/JInman/.vim/view
set viminfo+=n~/.vim/viminfo

set guioptions=egt
set guicursor+=a:blinkoff500-blinkon500
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
set foldtext=getline(v:foldstart)[0:30].repeat('>',48)
set formatoptions=qljnr
set ignorecase 
set laststatus=1
set linebreak 
set nohlsearch
set pastetoggle=<insert> 
set shell=/usr/bin/zsh
set shiftround 
set shiftwidth=2 
set showbreak=+
set smartcase 
set tabstop=2 
set textwidth=78 
set title
set undofile 
set virtualedit=block
set wildmenu

" get highlight group
function! GetHighlight()
    let hi    = synIDattr(synID(line('.'), col('.'), 1), 'name')
    let trans = synIDattr(synID(line('.'), col('.'), 0), 'name')
    let lo    = synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    echo 'hi:' . hi . ', trans:' . trans . ', lo:' . lo
endfunction
nnoremap <leader>hi :call GetHighlight()<cr>

" maps
inoremap jk <esc>
xnoremap Y "+y
nnoremap <backspace> :bdelete<cr>
nnoremap <leader>w :wincmd w<cr>

function! GoToNonTerminalBuffer(direction)
  let current_bufnr = bufnr('%')
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val)')
  let index = index(buffers, current_bufnr)
  " Cycle through buffers
  while index >= 0
    if a:direction == 'previous'
      let index = (index - 1 + len(buffers)) % len(buffers)
    else
      let index = (index + 1) % len(buffers)
    endif
    let next_bufnr = buffers[index]
    if getbufvar(next_bufnr, '&buftype') !=# 'terminal'
      execute 'buffer' next_bufnr
      return
    endif
    " If back to the start, no non-terminal buffer found
    if next_bufnr == current_bufnr
      echo "No non-terminal buffer found."
      return
    endif
  endwhile
endfunction

nnoremap <c-j> :call GoToNonTerminalBuffer('next')<cr>
nnoremap <c-k> :call GoToNonTerminalBuffer('previous')<cr>

" command abbreviations
cnoreabbrev h tab help

" folds
augroup folds
  au!
  autocmd BufWinEnter * if getline(1) =~ 'foldenable' | execute 'loadview' | endif
  autocmd BufWinLeave * if getline(1) =~ 'foldenable' | execute 'mkview!' | endif
augroup end

" vimrc
augroup vimrc
    au!
    autocmd BufWritePost .vimrc,*.vim source $MYVIMRC
augroup end

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

" markdown
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

" repl
let g:slime_target = "vimterminal"
let g:slime_no_mappings = 1
let g:slime_bracketed_paste = 1
let g:slime_default_config = {"bufnr": "2"}
let g:slime_dont_ask_default = 1

function! OpenREPL(...) " Accept optional arguments
  let l:interpreter = a:0 > 0 ? a:1 : ''
  if l:interpreter == ''
    if &filetype == 'python'
      let l:interpreter = 'python'
    elseif &filetype == 'r'
      let l:interpreter = 'R --quiet --no-save'
    else
      let l:interpreter = 'zsh'
    endif
  endif
  execute 'rightbelow vertical terminal ' l:interpreter
  wincmd p
  " make sure after wincmd so b scoping works
  let b:terminal_buffer_id = '!' . l:interpreter
endfunction

command! -nargs=? OpenREPL call OpenREPL(<f-args>)

function! CloseREPL(terminal_buffer_id) " Accept optional arguments
  execute 'bdelete! ' a:terminal_buffer_id
endfunction

command! CloseREPL call CloseREPL(b:terminal_buffer_id)

function! SendLine(terminal_buffer_id)
  let l:current_line = getline('.')
  call term_sendkeys(a:terminal_buffer_id, l:current_line . "\n")
endfunction

nnoremap , :call SendLine(b:terminal_buffer_id)<cr>

function! SendSelection(terminal_buffer_id) range
  let l:lines = getline(a:firstline, a:lastline)
  if a:terminal_buffer_id == '!python'
    let l:block = "exec(\"\"\"" . join(l:lines, "\n") . "\"\"\")\n"
    call term_sendkeys(a:terminal_buffer_id, l:block)
  else
    for l:line in l:lines
      call term_sendkeys(a:terminal_buffer_id, l:line . "\n")
    endfor
  endif
endfunction

xnoremap , :call SendSelection(b:terminal_buffer_id)<cr>

