let maplocalleader = ' '

function! ViewTable()
  let table = expand('<cword>')
  setlocal shellslash
  let temp_file = tempname() . '.xlsx'
  " setlocal noshellslash
  let write_command = 'openxlsx::write.xlsx(' . table . ', "' . temp_file . '")'
  execute 'call SendAsString(' . write_command . ')'
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

nnoremap <buffer> <localLeader>rc :call SendAsString('ncol(<c-r><c-w>)', b:pane_id)<cr>
nnoremap <buffer> <localLeader>rg :call SendAsString('glimpse(<c-r><c-w>)', b:pane_id)<cr>
nnoremap <buffer> <localLeader>rh :call SendAsString('head(<c-r><c-w>)', b:pane_id)<cr>
nnoremap <buffer> <localLeader>ri :call SendAsString('<c-r><c-w>', b:pane_id)<cr>
nnoremap <buffer> <localLeader>rl :call SendAsString('length(<c-r><c-w>)', b:pane_id)<cr>
nnoremap <buffer> <localLeader>rn :call SendAsString('names(<c-r><c-w>)', b:pane_id)<cr>
nnoremap <buffer> <localLeader>rr :call SendAsString('nrow(<c-r><c-w>)', b:pane_id)<cr>
nnoremap <buffer> <localLeader>rs :call SendAsString('str(<c-r><c-w>)', b:pane_id)<cr>
nnoremap <buffer> <localLeader>rv :call SendAsString('View(<c-r><c-w>)', b:pane_id)<cr>
nnoremap <buffer> K :call SendAsString('help(<c-r><c-w>)', b:pane_id)<cr>

