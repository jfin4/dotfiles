inoremap <buffer> < <-
inoremap <buffer> << <
inoremap <buffer> > %>%
inoremap <buffer> >> >
nnoremap <buffer> K :call SendCode(['help(<c-r><c-w>)'])<cr>

function! EchoLastCommand()"{{{
    let repl_file = GetReplFile()
    let repl_command = printf('source("%s", echo = TRUE, max.deparse.length = Inf)',
                \ repl_file)
    call term_sendkeys(b:repl_buf, repl_command . "\r")
endfunction
command! EchoLastCommand call EchoLastCommand()
"}}}
function! DoWithObject(command, type = '') abort"{{{
    if a:type == ''
        let &operatorfunc = function('DoWithObject', [a:command])
        return 'g@'
    endif
    let selection = {
                \ 'line': "'[V']",
                \ 'char': "`[v`]",
                \ 'block': "`[\<C-V>`]",
                \ }[a:type]
    execute printf('silent normal! %s"ry', 
                \ selection)
    let object = split(@r, "\n")
                \ ->map({_, v -> substitute(v, '\s*#.*', '', '')})
                \ ->map({_, v -> substitute(v, '\s\+', ' ', '')})
    let code = printf('print(%s({%s}))', 
                \ a:command, 
                \ object->join(''))
    call SendCode([code])
endfunction
let keymaps = [
            \ ['c', 'ncol'],
            \ ['g', 'glimpse'],
            \ ['h', 'head'],
            \ ['p', ''],
            \ ['l', 'length'],
            \ ['n', 'names'],
            \ ['r', 'nrow'],
            \ ['s', 'str'],
            \ ['V', 'View'],
            \ ]
for keymap in keymaps
    execute printf(
            \ 'nnoremap <expr> <localleader>r%s DoWithObject("%s", "")',
            \ keymap[0],
            \ keymap[1],
        \)
    execute printf(
            \ 'xnoremap <expr> <localleader>r%s DoWithObject("%s", "")',
            \ keymap[0],
            \ keymap[1],
        \)
    execute printf(
            \ 'nnoremap <expr> <localleader>r%s%s DoWithObject("%s", "") .. "_"',
            \ keymap[0],
            \ keymap[0],
            \ keymap[1],
        \)
endfor
"}}}
function! ViewObject(type = '') abort"{{{
    if a:type == ''
        let &operatorfunc = 'ViewObject'
        return 'g@'
    endif
    let selection = {
                \ 'line': "'[V']",
                \ 'char': "`[v`]",
                \ 'block': "`[\<C-V>`]",
                \ }[a:type]
    execute printf('silent normal! %s"ry', 
                \ selection)
    let object = split(@r, "\n")
                \ ->map({_, v -> substitute(v, '\s*#.*', '', '')})
                \ ->map({_, v -> substitute(v, '\s\+', ' ', '')})
    let file_name = printf('%s/.%s-%s.csv', 
                \ expand('%:p:h'),
                \ object->get(0)->substitute('\W\+', '', 'g'),
                \ rand())
    if hostname() == "WB-102575"
        let file_name = file_name->substitute('/c', 'c:', '')
    endif
    let code = printf('readr::write_csv({%s}, "%s")', 
                \ object->join(''), 
                \ file_name)
    call SendCode([code])
    while 1
        if filereadable(file_name)
            " execute printf('terminal visidata --theme=ascii8 %s', 
            execute printf('call system(''launch-file "%s"'')',
                        \ file_name)
            execute printf('autocmd VimLeavePre * call delete("%s")', 
                        \ file_name)
            return
        endif
        sleep 1
    endwhile
endfunction
nnoremap <expr> <localleader>rv ViewObject()
xnoremap <expr> <localleader>rv ViewObject()
nnoremap <expr> <localleader>rvv ViewObject() .. '_'
"}}}
function! TogglePipe()"{{{
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
nnoremap <buffer> <localleader>> :call TogglePipe()<cr> 
"}}}
