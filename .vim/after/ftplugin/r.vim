let g:mucomplete#empty_text = 1

function! SaveTable(args)
  normal! gv"xy
  let table = substitute(@x, '\n', '', 'g')
  let file = tempname() . '.csv'
  if a:args.head
      " needs to be a list for writefile() in sendcode()
      let code = [ printf('readr::write_csv(head(%s), "%s")', table, file) ]
  else
      let code = [ printf('readr::write_csv(%s, "%s")', table, file) ] 
  endif
  call SendCode({'code': code, 'echo': 'TRUE'})
  return file
endfunction

function! OpenTable()
    call system(printf('tmux split-window visidata "%s"', b:file))
endfunction

function! ExploreTable(args) range
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

function! s:MakeRKeymaps(args)
    let command = 
        \printf(
            \'nnoremap <buffer> 
                \%s 
                \:call SendCode(
                    \{ 
                        \''code'': [''%s''], 
                        \''echo'': ''TRUE'' 
                    \})<cr>',
            \a:args.lhs,
            \a:args.rhs
        \)
    execute command
endfunction

let keymaps = [
            \{ 'lhs': '<localleader>rc', 'rhs': 'ncol(<c-r><c-w>)' },
            \{ 'lhs': '<localleader>rg', 'rhs': 'glimpse(<c-r><c-w>)' },
            \{ 'lhs': '<localleader>rh', 'rhs': 'head(<c-r><c-w>)' },
            \{ 'lhs': '<localleader>ri', 'rhs': '<c-r><c-w>' },
            \{ 'lhs': '<localleader>rl', 'rhs': 'length(<c-r><c-w>)' },
            \{ 'lhs': '<localleader>rn', 'rhs': 'names(<c-r><c-w>)' },
            \{ 'lhs': '<localleader>rr', 'rhs': 'nrow(<c-r><c-w>)' },
            \{ 'lhs': '<localleader>rs', 'rhs': 'str(<c-r><c-w>)' },
            \{ 'lhs': '<localleader>rv', 'rhs': 'View(<c-r><c-w>)' },
            \{ 'lhs': 'K',               'rhs': 'help(<c-r><c-w>)' }
            \]

for k in keymaps
    call s:MakeRKeymaps(k)
endfor
