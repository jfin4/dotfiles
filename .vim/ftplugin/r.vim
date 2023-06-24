let R_external_term = 1
let R_assign = 0
" let R_app = 'C:\Program Files\R\R-4.2.3\bin\x64\Rgui.exe'
" let R_cmd = 'C:\Program Files\R\R-4.2.3\bin\x64\R.exe'

" if has('gui_running') && has('win32')

inoremap <buffer> -- <esc>0i# <esc>76a-<esc>0f-R
inoremap <buffer> < <-
inoremap <buffer> << <
inoremap <buffer> > %>%
inoremap <buffer> >> >
nnoremap <buffer> , <Plug>RSendLine
nnoremap <buffer> K :execute 'RSend ?' . expand('<cword>')<cr>
nnoremap <buffer> <localleader>new mx$a # new<esc>`x
xnoremap <buffer> , <Plug>RSendSelection<esc>

cnoreabbrev er e $LOCALAPPDATA/Programs/msys64/home/JInman/.vim/ftplugin/r.vim



