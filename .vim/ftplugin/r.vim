let R_external_term = 1
let R_assign = 0
let maplocalleader = ' '

" if has('gui_running') && has('win32')

function! ViewTable()
  let table = expand('<cword>')
  setlocal shellslash
  let temp_file = tempname() . '.xlsx'
  setlocal noshellslash
  let write_command = 'openxlsx::write.xlsx(' . table . ', "' . temp_file . '")'
  execute 'RSend ' . write_command
  let counter = 30
  while counter > 0
    if filereadable(temp_file)
      call system(temp_file)
      break
    endif
    let counter -= 1
    sleep
  endwhile
endfunction

inoremap <buffer> -- <esc>0i# <esc>76a-<esc>0f-R
inoremap <buffer> --- ---
inoremap <buffer> < <-
inoremap <buffer> << <
inoremap <buffer> > %>%
inoremap <buffer> >> >
nnoremap <buffer> , <Plug>RSendLine
nnoremap <buffer> <localleader>new mx$a # new<esc>`x
nnoremap <buffer> <localleader>vt :call ViewTable()<cr>
nnoremap <buffer> K :execute 'RSend ?' . expand('<cword>')<cr>
xnoremap <buffer> , <Plug>RSendSelection<esc>
