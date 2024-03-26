let maplocalleader = ' '

function! ViewTable() range
  call SaveTable()
  let wait_time = '5'
  while wait_time > 0
    if filereadable(b:temp_file)
      call ViewSavedTable()
      return
    endif
    let wait_time -= 1
    sleep 1
  endwhile
  echo 'Still writing file. Call ViewSavedTable when finished.'
endfunction
xnoremap <localleader>vt :<c-u>silent! call ViewTable()<cr>

function! SaveTable()
  " Capture the visual selection
  let saved_reg = @"
  normal! gvy
  let table = @"
  let @" = saved_reg
  let b:temp_file = tempname() . '.txt'
  " because R is running in Windows
  let win_temp_file = substitute(b:temp_file, '^', 'c:/msys64', '')
  let r_cmd = 'write_tsv(' . table . ', "' . win_temp_file . '")'
  call SendAsString(r_cmd)
endfunction
command! SaveTable call SaveTable()

function! ViewSavedTable()
  call system('cygstart ' . shellescape(b:temp_file))
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

