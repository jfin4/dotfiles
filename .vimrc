" vim: set ft=vim :
filetype indent plugin on
syntax on
colorscheme jfin

" variables
let mapleader = ' '
let maplocalleader = ' '

" settings
source $VIMRUNTIME/defaults.vim

set backupdir=c:/msys64/home/JInman/.vim/backup
set directory=c:/msys64/home/JInman/.vim/swap
set undodir=c:/msys64/home/JInman/.vim/undo 
set viewdir=c:/msys64/home/JInman/.vim/view
set viminfo+=nc:/msys64/home/JInman/.vim/viminfo

set guioptions=egt
set guicursor+=a:blinkoff500-blinkon500
set guifont=Terminus_(TTF)_for_Windows:h12

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
set shell=/usr/bin/sh
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

" open file under cursor
function! OpenLink()
  let link = trim(getline('.'))
  if has('gui_running') && has('win32')
    call system('start "" ' . shellescape(link))
  else
    call system('cygstart ' . shellescape(link))
  endif
endfunction
nnoremap <cr> :call OpenLink()<cr>

" maps
inoremap jk <esc>
xnoremap Y "*y
nnoremap <backspace> :bdelete<cr>
nnoremap <leader>w :wincmd w<cr>
nnoremap <c-j> :bnext<cr>
nnoremap <c-k> :bprevious<cr>

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
    autocmd BufWritePost _vimrc,.vimrc,*.vim source $MYVIMRC
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
function! OpenREPL(...)
  " allows interpreter override for python venvs
  let interpreter = a:0 > 0 ? a:1 : ''
  if interpreter == ''
    if &filetype == 'python'
      let interpreter = 'python'
    elseif &filetype == 'r'
      let interpreter = 'R --quiet --no-save'
    else
      let interpreter = ''  " Default to shell if no filetype match
    endif
  endif
  let tmux_command = 'tmux split-window -h -P -F "#{pane_id}" ' . interpreter
  " opens repl and captures pane id
  let pane_id = system(tmux_command)
  let b:pane_id = substitute(pane_id, '\n\+$', '', '')
  call system('tmux select-pane -t {last}')
endfunction
command! -nargs=? OpenREPL call OpenREPL(<f-args>)

function! CloseREPL(pane_id) 
  call system('tmux kill-pane -t '. a:pane_id)
endfunction
command! CloseREPL call CloseREPL(b:pane_id)

function! SendString(string, pane_id)
  " used in SendLine() and SendSelection()
  " some instances also are mapped in ftplugin/r.vim
  let command = 'tmux send-keys -t ' . a:pane_id . ' ' . shellescape(a:string) . ' Enter'
  call system(command)
endfunction

function! SendLine(pane_id)
  let line = getline('.')
  call SendString(line, a:pane_id)
endfunction
nnoremap , :call SendLine(b:pane_id)<cr>

function! SendChunk(chunk, pane_id)
  " used in SendSelection() and SendFile()
  let temp_file = tempname()
  let win_temp_file = substitute(temp_file, '^', 'c:/msys64', '')
  call writefile(a:chunk, temp_file)
  "
  if &filetype == 'python'
    let command = 'exec(open("' . temp_file . '").read())'
  elseif &filetype == 'r'
    let command = 'source("' . win_temp_file . '", echo = TRUE)'
  else
    let command = 'source "' . temp_file . '"'
  endif
  "
  call SendString(command, a:pane_id)
endfunction

function! SendSelection(pane_id)
  " Capture the visual selection
  let saved_reg = @"
  normal! gv"xy
  let selection = @x
  let @" = saved_reg
  " Check if the selection is truly single line
  if selection !~ '\n'
    call SendString(selection, a:pane_id)
  else
    let selection = split(selection, "\n")
    call SendChunk(selection, a:pane_id)
  endif
endfunction
xnoremap , :<C-u>silent! call SendSelection(b:pane_id)<CR>

function! SendFile(pane_id)
  let current_line = line('.')
  let file_to_line = getline(1, current_line)
  call SendChunk(file_to_line, a:pane_id)
endfunction
nnoremap <leader>, :call SendFile(b:pane_id)<CR>
