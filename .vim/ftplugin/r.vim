let R_external_term = 0
let R_assign = 0
let maplocalleader = ' '
let R_path = "C:\\Program Files\\R\\R-4.3.1\\bin\\x64"
let R_user_maps_only = 1
" let R_app = 'Rgui.exe'
" let R_cmd = 'R.exe'

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

nnoremap <buffer> <localleader>vt :call ViewTable()<cr>

nnoremap <buffer> K :SlimeSend1 help(<c-r><c-w>)<cr>

nnoremap <buffer> <localLeader>rh :SlimeSend1 head(<c-r><c-w>)<cr>
nnoremap <buffer> <localLeader>rn :SlimeSend1 nrow(<c-r><c-w>)<cr>
nnoremap <buffer> <localLeader>rc :SlimeSend1 ncol(<c-r><c-w>)<cr>
nnoremap <buffer> <localLeader>rs :SlimeSend1 str(<c-r><c-w>)<cr>
nnoremap <buffer> <localLeader>rm :SlimeSend1 names(<c-r><c-w>)<cr>
nnoremap <buffer> <localLeader>rl :SlimeSend1 length(<c-r><c-w>)<cr>

nnoremap <buffer> <localLeader>ro :SlimeSend1 q()<cr>
