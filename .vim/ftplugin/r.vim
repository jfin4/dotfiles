let maplocalleader = ' '

function! SaveTable(pane_id)
  let table = expand('<cword>')
  let b:temp_file = tempname() . '.xlsx'
  let win_temp_file = substitute(b:temp_file, '^', 'c:/msys64', '')
  let r_cmd = 'openxlsx::write.xlsx(' . table . ', "' . win_temp_file . '")'
  call SendAsString(r_cmd, a:pane_id)
endfunction
command! SaveTable call SaveTable(b:pane_id, <f-args>)

function! ViewTable(temp_file)
  call system('cygstart ' . a:temp_file)
endfunction
command! ViewTable call ViewTable(b:temp_file)

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

