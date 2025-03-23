function! ViewTable(table) abort
    let table = a:table
    let table_file = table
                \ ->substitute('[^a-zA-Z0-9]\+', '-', 'g')
                \ ->substitute('-$', '', '')
    let table_file = '.' .. table_file .. '.csv'
    let code = printf('readr::write_csv(%s, "%s")', table, table_file)
    call RunCode({'code': [code], 'echo': 'FALSE'})
    while 1
        if filereadable(table_file)
            execute 'terminal visidata --theme=ascii8 ' . table_file
            execute 'autocmd BufDelete <buffer=' . bufnr() . '> '
                        \ . 'call delete("' . table_file . '")'
            return
        endif
        sleep 1
    endwhile
endfunction

function! ViewTableMap(method, ...) abort
    let table = call('GetCode', [a:method] + a:000).code
                \ ->map({_, v -> substitute(v, '#.*', '', '')})
                \ ->join('')
    call ViewTable(table)

    " Set up for repeat based on the method type
    if a:method ==# 'line'
        silent! call repeat#set("\<Plug>ViewTableLine", v:count)
    elseif a:method ==# 'text_object'
        if a:1 ==# 'p'
            silent! call repeat#set("\<Plug>ViewTableTextObjectP", v:count)
        elseif a:1 ==# 'w'
            silent! call repeat#set("\<Plug>ViewTableTextObjectW", v:count)
        elseif a:1 ==# '{'
            silent! call repeat#set("\<Plug>ViewTableTextObjectCurly", v:count)
        endif
    endif
endfunction

function! ViewTableOp(type) abort
    let table = GetCode('motion', a:type).code[0]
    call ViewTable(table)
    " allow . repeat
    silent! call repeat#set("\<Plug>ViewTableMotion", v:count)
endfunction

" Define <Plug> mappings - each with a unique name
nnoremap <silent> <Plug>ViewTableLine           :call ViewTableMap('line')<CR>
nnoremap <silent> <Plug>ViewTableTextObjectP    :call ViewTableMap('text_object', 'p')<CR>
nnoremap <silent> <Plug>ViewTableTextObjectW    :call ViewTableMap('text_object', 'w')<CR>
nnoremap <silent> <Plug>ViewTableTextObjectCurly :call ViewTableMap('text_object', '{')<CR>
xnoremap <silent> <Plug>ViewTableSelection      :<C-U>call ViewTableMap('selection')<CR>
nnoremap <silent> <Plug>ViewTableMotion         :set opfunc=ViewTableOp<CR>g@

" Map actual key sequences to the <Plug> mappings
nnoremap <silent> <localleader>tt    <Plug>ViewTableLine
xnoremap <silent> <localleader>t     <Plug>ViewTableSelection
nnoremap <silent> <localleader>t     <Plug>ViewTableMotion
nnoremap <silent> <localleader>tip   <Plug>ViewTableTextObjectP
nnoremap <silent> <localleader>tiw   <Plug>ViewTableTextObjectW
nnoremap <silent> <localleader>ti{   <Plug>ViewTableTextObjectCurly

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
            \'nnoremap <buffer> %s 
                \:call RunCode({''code'': [''%s''], ''echo'': ''TRUE''})<cr>',
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
