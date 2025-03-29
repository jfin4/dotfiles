function! ViewTable(type = '') abort
    if a:type == ''
        set operatorfunc=ViewTable
        return 'g@'
    endif
    let commands = {
                \ 'line': "'[V']",
                \ 'char': "`[v`]",
                \ 'block': "`[\<C-V>`]",
                \ }[a:type]
    execute printf('silent normal! %s"ry', 
                \ commands)
    let table = split(@r, "\n")
    let file_name = printf('%s.csv', 
                \ table[0]->substitute('[^a-z]', '', 'g'))
    let code = printf('readr::write_csv({%s}, "%s")', 
                \ table->join(''), 
                \ file_name)
    call Run([code], 'FALSE')
    while 1
        if filereadable(file_name)
            execute printf('terminal visidata --theme=ascii8 %s', 
                        \ file_name)
            execute printf('autocmd BufDelete <buffer=%d> call delete("%s")', 
                        \ bufnr(), 
                        \ file_name)
            return
        endif
        sleep 1
    endwhile
endfunction
nnoremap <expr> <localleader>t ViewTable()
xnoremap <expr> <localleader>t ViewTable()
nnoremap <expr> <localleader>tt ViewTable() .. '_'

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
            \'nnoremap <buffer> %s :call Run([''%s''], ''TRUE'')<cr>',
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
