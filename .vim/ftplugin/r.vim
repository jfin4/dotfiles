let maplocalleader = ' '

function! ViewTable()
  call SaveTable()
  let wait_time = '5'
  while wait_time > 0
    if filereadable(b:temp_file)
      call ViewSavedTable()
      break
    endif
    let wait_time -= 1
    sleep
  endwhile
  echo 'Still writing file. Call ViewSavedTable when finished.'
endfunction
command! ViewTable call ViewTable()

function! SaveTable()
  " Capture the visual selection
  let saved_reg = @"
  normal! gvy
  let table = @"
  let @" = saved_reg
  let b:temp_file = tempname() . '.xlsx'
  let win_temp_file = substitute(b:temp_file, '^', 'c:/msys64', '')
  let r_cmd = 'openxlsx::write.xlsx(' . table . ', "' . win_temp_file . '")'
  call SendAsString(r_cmd, b:pane_id)
endfunction
command! SaveTable call SaveTable()

function! ViewSavedTable()
  call system('cygstart ' . b:temp_file)
endfunction
command! ViewSavedTable call ViewSavedTable()

inoremap <buffer> < <-
inoremap <buffer> << <
inoremap <buffer> > %>%
inoremap <buffer> >> >

nnoremap <buffer> <localLeader>rc :call SendAsString('ncol(<c-r><c-w>)')<cr>
nnoremap <buffer> <localLeader>rg :call SendAsString('glimpse(<c-r><c-w>)')<cr>
nnoremap <buffer> <localLeader>rh :call SendAsString('head(<c-r><c-w>)')<cr>
nnoremap <buffer> <localLeader>ri :call SendAsString('<c-r><c-w>')<cr>
nnoremap <buffer> <localLeader>rl :call SendAsString('length(<c-r><c-w>)')<cr>
nnoremap <buffer> <localLeader>rn :call SendAsString('names(<c-r><c-w>)')<cr>
nnoremap <buffer> <localLeader>rr :call SendAsString('nrow(<c-r><c-w>)')<cr>
nnoremap <buffer> <localLeader>rs :call SendAsString('str(<c-r><c-w>)')<cr>
nnoremap <buffer> <localLeader>rv :call SendAsString('View(<c-r><c-w>)')<cr>
nnoremap <buffer> K :call SendAsString('help(<c-r><c-w>)')<cr>

