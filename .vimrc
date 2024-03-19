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
let g:slime_target = "vimterminal"
let g:slime_no_mappings = 1
let g:slime_bracketed_paste = 1
let g:slime_default_config = {"bufnr": "2"}
let g:slime_dont_ask_default = 1

function! OpenREPL(...)
  " Determine the interpreter based on filetype or argument
  let interpreter = a:0 > 0 ? a:1 : ''
  if interpreter == ''
    if &filetype == 'python'
      let interpreter = 'python'
    elseif &filetype == 'r'
      let interpreter = 'R --quiet --no-save'
    else
      let interpreter = 'zsh'  " Default to Zsh if no filetype match
    endif
  endif
  " Construct and execute the tmux command
  let tmux_command = 'tmux split-window -h -P -F "#{pane_id}" ' . interpreter
  " Execute the tmux command and capture the output, which includes the new pane ID
  let pane_id = system(tmux_command)
  " Remove trailing newline from the output
  let b:pane_id = substitute(pane_id, '\n\+$', '', '')
  " refocus original pane
  call system('tmux select-pane -t {last}')
endfunction

command! -nargs=? OpenREPL call OpenREPL(<f-args>)

function! CloseREPL(pane_id) " Accept optional arguments
  call system('tmux kill-pane -t '. a:pane_id)
endfunction

command! CloseREPL call CloseREPL(b:pane_id)

function! SendLine(pane_id)
  let line = getline('.')
  let tmux_command = 'tmux send-keys -t ' . a:pane_id . ' ' . shellescape(line) . ' Enter'
  call system(tmux_command)
endfunction

nnoremap , :call SendLine(b:pane_id)<cr>

function! SendSelection(pane_id)
  " Capture the visual selection
  let saved_reg = @"
  normal! gv"xy
  let selection = @x
  let @" = saved_reg
  " use exec() trick for python
  if &filetype == 'python'
    let selection = 'exec("""' . selection . '""")'
  endif
  " Construct and execute the tmux command
  let tmux_command = 'tmux load-buffer - ; tmux paste-buffer -t ' . a:pane_id
  call system('echo ' . shellescape(selection) . ' | ' . tmux_command)
endfunction

xnoremap , :<C-u>silent! call SendSelection(b:pane_id)<CR>

function! SendString(string, pane_id)
  let tmux_command = 'tmux send-keys -t ' . a:pane_id . ' ' . shellescape(a:string) . ' Enter'
  call system(tmux_command)
endfunction

function! SendFile(pane_id)
  let filepath = expand('%')  " Get the full path of the current file
  if &filetype == 'python'
    " Python Use exec() to execute the file's contents in the interactive session
    let command = 'exec(open("' . filepath . '").read())'
  elseif &filetype == 'r'
    " R Use source() to execute the file in the interactive session
    let command = 'source("' . filepath . '")'
  else
    let command = 'source "' . filepath . '"'
  endif
  " Prepare the command for sending to tmux
  let tmux_command = 'tmux send-keys -t ' . a:pane_id . ' ' . shellescape(command) . ' Enter'
  " Execute the tmux command
  call system(tmux_command)
endfunction

nnoremap <leader>f :call SendFile(b:pane_id)<CR>
