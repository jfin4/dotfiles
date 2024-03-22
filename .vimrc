" vim: foldenable

" initial commands
filetype indent plugin on
syntax on
colorscheme jfin

" define variables
let mapleader = ' '
let maplocalleader = ' '

" settings
" default options first, following can override
source $VIMRUNTIME/defaults.vim

" dir options
set backupdir=c:/msys64/home/JInman/.vim/backup
set directory=c:/msys64/home/JInman/.vim/swap
set undodir=c:/msys64/home/JInman/.vim/undo 
set viewdir=c:/msys64/home/JInman/.vim/view
set viminfo+=nc:/msys64/home/JInman/.vim/viminfo

" gui options
set guioptions=egt
set guicursor+=a:blinkoff500-blinkon500
set guifont=Terminus_(TTF)_for_Windows:h12

" other options
set autoread 
set autowriteall
set completeopt=menu,menuone " mucomplete needs menuone
set encoding=utf-8
set fillchars=vert:\ ,fold:\ ,eob:\ 
set formatoptions=qljnr
set ignorecase 
set laststatus=1
set nohlsearch
set pastetoggle=<insert> 
set shell=/usr/bin/sh
set smartcase 
set title
set undofile 
set virtualedit=block
set wildmenu

" maps
inoremap jk <esc>
xnoremap Y "*y
nnoremap <backspace> :bdelete<cr>
nnoremap <leader>w :wincmd w<cr>
nnoremap <c-n> :bnext<cr>
nnoremap <c-p> :bprevious<cr>

" command abbreviations
cnoreabbrev h tab help

" indentation
set autoindent 
set breakindent 
set breakindentopt=min:0,shift:1
set expandtab 
set linebreak 
set shiftround 
set shiftwidth=2 
set showbreak=+
set tabstop=2 
set textwidth=78 

" folds
set foldlevel=0
augroup folds
  au!
  autocmd BufWinEnter * if getline(1) =~ 'foldenable' | execute 'loadview' | endif
  autocmd BufWinLeave * if getline(1) =~ 'foldenable' | execute 'mkview!' | endif
augroup end

" snippets
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

" completion
let g:mucomplete#chains = {
    \ 'default' : ['path', 'omni', 'keyp', 'dict', 'uspl'],
    \ 'vim'     : ['path', 'cmd', 'keyn']
    \ }
imap <expr> . mucomplete#extend_bwd(".")

" vimrc
augroup vimrc
    au!
    autocmd BufWritePost _vimrc,.vimrc,*.vim source $MYVIMRC
augroup end

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

function! ShareREPL()
  if exists("b:pane_id")
    let g:pane_id = b:pane_id
  else
    let b:pane_id = g:pane_id
  endif
endfunction
command! ShareREPL call ShareREPL()

function! CloseREPL(pane_id) 
  call system('tmux kill-pane -t '. a:pane_id)
endfunction
command! CloseREPL call CloseREPL(b:pane_id)

function! SendAsString(text, pane_id)
  " used in SendSelection()
  " some instances also are mapped in ftplugin/r.vim
  let command = 'tmux send-keys -t ' . a:pane_id . ' ' . shellescape(a:text) . ' Enter'
  call system(command)
endfunction

function! SendAsFile(text, pane_id, echo)
  " used in SendSelection() and SendFile()
  let temp_file = tempname()
  let win_temp_file = substitute(temp_file, '^', 'c:/msys64', '')
  call writefile(a:text, temp_file)
  "
  if &filetype == 'python'
    let command = 'exec(open("' . temp_file . '").read())'
  elseif &filetype == 'r'
    let command = 'suppressWarnings(suppressMessages(source("'.win_temp_file.'", '.
                \ 'echo = '.a:echo.', '.
                \ 'max.deparse.length = Inf)))'
  else
    let command = 'source "' . temp_file . '"'
  endif
  "
  call SendAsString(command, a:pane_id)
endfunction

function! SendLine(pane_id)
  let line = getline('.')
  call SendAsString(line, a:pane_id)
endfunction
nnoremap , :call SendLine(b:pane_id)<CR>

function! SendParagraph(pane_id)
  " Get the line number of the start and end of the paragraph
  let start_line = line("'{")
  let end_line = line("'}")
  let paragraph = getline(start_line, end_line)
  let paragraph = filter(paragraph, 'v:val !~ "^\\s*$"')
  if len(paragraph) > 1 
    call SendAsFile(paragraph, a:pane_id, 'TRUE')
  else
    call SendAsString(paragraph[0], a:pane_id)
  endif
endfunction
" nnoremap , :call SendParagraph(b:pane_id)<CR>

function! SendSelection(pane_id)
  " Capture the visual selection
  let saved_reg = @"
  normal! gv"xy
  let selection = @x
  let @" = saved_reg
  " Check if the selection is single line
  if selection !~ '\n\zs.'
    call SendAsString(selection, a:pane_id)
  else
    let selection = split(selection, "\n")
    call SendAsFile(selection, a:pane_id, 'TRUE')
  endif
endfunction
xnoremap , :<C-u>silent! call SendSelection(b:pane_id)<CR>

function! SendFile(pane_id)
  let current_line = line('.')
  let file_to_line = getline(1, current_line)
  call SendAsFile(file_to_line, a:pane_id, 'FALSE')
endfunction
nnoremap <leader>, :call SendFile(b:pane_id)<CR>


" get highlight group
function! GetHighlight()
    let hi    = synIDattr(synID(line('.'), col('.'), 1), 'name')
    let trans = synIDattr(synID(line('.'), col('.'), 0), 'name')
    let lo    = synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    echo 'hi:' . hi . ', trans:' . trans . ', lo:' . lo
endfunction
nnoremap <leader>hi :call GetHighlight()<cr>

" follow link
function! FollowLink()
  let link = trim(getline('.'))
  if has('gui_running') && has('win32')
    call system('start "" ' . shellescape(link))
  else
    call system('cygstart ' . shellescape(link))
  endif
endfunction
nnoremap <cr> :call FollowLink()<cr>

