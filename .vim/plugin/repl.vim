" repl
function! OpenRepl()
    terminal R --quiet --no-save
    let repl_buf = bufnr() 
    wincmd w
    call DWM_Focus()
    let b:repl_buf = repl_buf
    let g:repl_file = '.repl-code.r'
    execute printf('autocmd BufDelete <buffer=%s> call delete("%s")',
                \ repl_buf,
                \ g:repl_file)
endfunction
command! OpenRepl call OpenRepl()
            
function! CloseRepl() 
    execute 'bdelete! ' . b:repl_buf
endfunction
command! CloseRepl call CloseRepl()

function! SetReplBuf()
    " Show buffer list in a way that ensures visibility
    redir => buflist
    silent ls
    redir END

    " Display the buffer list
    echo buflist

    " Get buffer number from user
    let b:repl_buf = 
                \input("\nEnter REPL buffer number: ")->
                \str2nr()
endfunction
command! SetReplBuf call SetReplBuf()

function! ReplRun(code = [], echo = 'TRUE') abort
    call writefile(a:code, g:repl_file)
    let repl_command = printf(
        \ 'suppressWarnings(suppressMessages(source(max = Inf, echo = %s, "%s")))',
        \ a:echo,
        \ g:repl_file)
    if !exists('b:repl_buf')
        call SetReplBuf()
    endif
    call term_sendkeys(b:repl_buf, repl_command . "\r")
endfunction

function! RunMotion(type = '') abort
    if a:type == ''
        let &operatorfunc = matchstr(expand('<sfile>'), '\w\+$')
        return 'g@'
    endif
    let commands = {
                \ 'line': "'[V']",
                \ 'char': "`[v`]",
                \ 'block': "`[\<C-V>`]",
                \ }[a:type]
    execute printf('normal! %s"ry',
                \ commands)
    let code = split(@r, "\n")
    call ReplRun(code)
endfunction
nnoremap <expr> , RunMotion()
xnoremap <expr> , RunMotion()
nnoremap <expr> ,, RunMotion() .. '_'

function! RunSection() abort
    " Run from last mark 'r' to current line
    let mark_pos = getpos("'r")
    let current = line('.')
    if mark_pos[1] < current
        let start = mark_pos[1]
    else
        let start = 1
    endif
    mark r  " Update mark 'r'
    let code = getline(start, current)
    call ReplRun(code, 'FALSE')
endfunction
nnoremap <expr> g, RunSection()
