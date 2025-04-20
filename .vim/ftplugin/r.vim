inoremap <buffer> < <-
inoremap <buffer> << <
inoremap <buffer> > %>%
inoremap <buffer> >> >

              " lhs                rhs
let keymaps = [
            \ ['grc', 'ncol(<c-r><c-w>)'],
            \ ['grg', 'glimpse(<c-r><c-w>)'],
            \ ['grh', 'head(<c-r><c-w>)'],
            \ ['gri', '<c-r><c-w>'],
            \ ['grl', 'length(<c-r><c-w>)'],
            \ ['grn', 'names(<c-r><c-w>)'],
            \ ['grr', 'nrow(<c-r><c-w>)'],
            \ ['grs', 'str(<c-r><c-w>)'],
            \ ['grv', 'View(<c-r><c-w>)'],
            \ ['K',               'help(<c-r><c-w>)']
            \ ]

for keymap in keymaps
    execute printf(
            \ 'nnoremap <buffer> %s :call SendCode([''%s''], ''TRUE'')<cr>',
            \ keymap[0],
            \ keymap[1],
        \)
endfor

function! ViewTable(type = '') abort
    if a:type == ''
        let &operatorfunc = matchstr(expand('<sfile>'), '\w\+$')
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
                \ ->map({_, v -> substitute(v, '\s*#.*', '', '')})
                \ ->map({_, v -> substitute(v, '\s\+', ' ', '')})
    let file_name = printf('.%s-%s.csv', 
                \ table->get(0)->substitute('\W\+', '', 'g'),
                \ rand())
    let code = printf('readr::write_csv({%s}, "%s")', 
                \ table->join(''), 
                \ file_name)
    call SendCode([code], 'T')
    while 1
        if filereadable(file_name)
            " execute printf('terminal visidata --theme=ascii8 %s', 
            execute printf('call system("start %s")',
                        \ file_name)
            execute printf('autocmd VimLeavePre * call delete("%s")', 
                        \ file_name)
            return
        endif
        sleep 1
    endwhile
endfunction
nnoremap <expr> go ViewTable()
xnoremap <expr> go ViewTable()
nnoremap <expr> goo ViewTable() .. '_'

function! TogglePipe()
    let line = getline('.')
    if line =~ '%>%'
        let new_line = substitute(line, '\s\?%>%', '', '')
    elseif line =~ '#'
        let new_line = substitute(line, '#', '%>% #', '')
    else
        let new_line = printf('%s %%>%%', line)
    endif
    call setline('.', new_line)
endfunction
nnoremap <buffer> g> :call TogglePipe()<cr>
