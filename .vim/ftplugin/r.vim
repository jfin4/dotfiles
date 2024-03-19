let maplocalleader = ' '

function! ViewTable()
  let table = expand('<cword>')
  setlocal shellslash
  let temp_file = tempname() . '.xlsx'
  " setlocal noshellslash
  let write_command = 'openxlsx::write.xlsx(' . table . ', "' . temp_file . '")'
  execute 'SlimeSend1 ' . write_command
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

nnoremap <buffer> <localleader>vt :call ViewTable()<cr>

inoremap <buffer> < <-
inoremap <buffer> << <
inoremap <buffer> > %>%
inoremap <buffer> >> >

nnoremap <buffer> K :call SendString('help(<c-r><c-w>)', b:pane_id)<cr>
nnoremap <buffer> <localLeader>rh :call SendString('head(<c-r><c-w>)', b:pane_id)<cr>
nnoremap <buffer> <localLeader>rr :call SendString('nrow(<c-r><c-w>)', b:pane_id)<cr>
nnoremap <buffer> <localLeader>rc :call SendString('ncol(<c-r><c-w>)', b:pane_id)<cr>
nnoremap <buffer> <localLeader>rs :call SendString('str(<c-r><c-w>)', b:pane_id)<cr>
nnoremap <buffer> <localLeader>rn :call SendString('names(<c-r><c-w>)', b:pane_id)<cr>
nnoremap <buffer> <localLeader>rl :call SendString('length(<c-r><c-w>)', b:pane_id)<cr>
nnoremap <buffer> <localLeader>rg :call SendString('glimpse(<c-r><c-w>)', b:pane_id)<cr>

