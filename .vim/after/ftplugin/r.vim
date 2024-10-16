function! SaveTable(args)
  normal! gv"xy
  let table = substitute(@x, '\n', '', 'g')
  let file = tempname() . '.csv'
  if a:args.head
      " needs to be a list for writefile() in sendcode()
      let code = [ printf('readr::write_tsv(head(%s), "%s")', table, file) ]
  else
      let code = [ printf('readr::write_tsv(%s, "%s")', table, file) ] 
  endif
  call SendCode({'code': code, 'echo': 'TRUE'})
  return file
endfunction

function! OpenTable()
    call system(printf('tmux split-window -d visidata "%s"', b:file))
endfunction

function! ExploreTable(args) range
    echo 'hi'
    let b:file = SaveTable(a:args)
    let wait = '5'
    while wait > 0
        if filereadable(b:file)
            call OpenTable()
            return
        endif
        let wait -= 1
        sleep 1
    endwhile
    echo 'ExploreTable() timed out. Call OpenTable().'
endfunction
xnoremap <localleader>ee :<c-u>call ExploreTable({'head': 0})<cr>
xnoremap <localleader>eh :<c-u>call ExploreTable({'head': 1})<cr>

function! TogglePipe()
    let line = getline('.')
    if line =~ '%>%'
        let new_line = substitute(line, '\s\?%>%', '', '')
    else
        let new_line = line . ' %>%'
    endif
    call setline('.', new_line)
endfunction
nnoremap <buffer> <localleader>> :call TogglePipe()<cr>

inoremap <buffer> < <-
inoremap <buffer> << <
inoremap <buffer> > %>%
inoremap <buffer> >> >

nnoremap <buffer> <localLeader>rc 
        \:call SendCode({'code': ['ncol(<c-r><c-w>)'], 'echo': 'TRUE'})<cr>
nnoremap <buffer> <localLeader>rg 
        \:call SendCode({'code': ['glimpse(<c-r><c-w>)'], 'echo': 'TRUE'})<cr>
nnoremap <buffer> <localLeader>rh 
        \:call SendCode({'code': ['head(<c-r><c-w>)'], 'echo': 'TRUE'})<cr>
nnoremap <buffer> <localLeader>ri 
        \:call SendCode({'code': ['<c-r><c-w>'], 'echo': 'TRUE'})<cr>
nnoremap <buffer> <localLeader>rl 
        \:call SendCode({'code': ['length(<c-r><c-w>)'], 'echo': 'TRUE'})<cr>
nnoremap <buffer> <localLeader>rn 
        \:call SendCode({'code': ['names(<c-r><c-w>)'], 'echo': 'TRUE'})<cr>
nnoremap <buffer> <localLeader>rr 
        \:call SendCode({'code': ['nrow(<c-r><c-w>)'], 'echo': 'TRUE'})<cr>
nnoremap <buffer> <localLeader>rs 
        \:call SendCode({'code': ['str(<c-r><c-w>)'], 'echo': 'TRUE'})<cr>
nnoremap <buffer> <localLeader>rv 
        \:call SendCode({'code': ['View(<c-r><c-w>)'], 'echo': 'TRUE'})<cr>
nnoremap <buffer> K 
        \:call SendCode({'code': ['help(<c-r><c-w>)'], 'echo': 'TRUE'})<cr>
