" let R_external_term = 1
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
      call system('start "" ' . temp_file)
      break
    endif
    let counter -= 1
    sleep
  endwhile
endfunction

inoremap <buffer> < <-
inoremap <buffer> << <
inoremap <buffer> > %>%
inoremap <buffer> >> >
nnoremap <buffer> , <Plug>RSendLine
nnoremap <buffer> <c-,> <Plug>RSendLine/^ *[^#]<cr>
nnoremap <buffer> <localleader>new mx$a # new<esc>`x
nnoremap <buffer> <localleader>vt :call ViewTable()<cr>
xnoremap <buffer> , <Plug>RSendSelection<esc>

nnoremap <buffer> <localLeader>rh :call RAction("head")<cr>
nnoremap <buffer> <localLeader>rn :call RAction("nrow")<cr>
nnoremap <buffer> K               :call RAction("help")<cr>

nnoremap <buffer> <localLeader>ri <Plug>RStart<esc>
nnoremap <buffer> <localLeader>ro <Plug>RClose<esc>
nnoremap <buffer> <localLeader>rm <Plug>RObjectNames<esc>
nnoremap <buffer> <localLeader>rs <Plug>RObjectStr<esc>
