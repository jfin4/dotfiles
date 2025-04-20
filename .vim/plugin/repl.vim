" repl
function! OpenRepl()
    terminal R --quiet --no-save
    let repl_buf = bufnr()
    wincmd w
    let b:repl_buf = repl_buf
endfunction
command! OpenRepl call OpenRepl()

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

function! SendCode(code = [], echo = 'TRUE') abort
    if !exists('b:repl_buf')
        call SetReplBuf()
    endif
    let repl_file = printf('%s.repl', expand('%:p:r'))
    if hostname() == "WB-102575"
        let repl_file = repl_file->substitute("^/c", "c:", "")
    endif
    if !filereadable('repl_file')
        execute printf('autocmd VimLeavePre * call delete("%s")',
                    \ repl_file)
    endif
    call writefile(a:code, repl_file)
    let repl_command = printf(
        \ 'suppressWarnings(suppressMessages(source(max = Inf, echo = %s, "%s")))',
        \ a:echo,
        \ repl_file)
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
    call SendCode(code)
endfunction
nnoremap <expr> , RunMotion()
xnoremap <expr> , RunMotion()
nnoremap <expr> ,, RunMotion() .. '_'

function! RunSection() abort
    " Run from last mark 'r' to current line
    let mark_pos = getpos("'r")[1] " lnum
    let current = line('.')
    if mark_pos < current && mark_pos > 0 " might not be set
        let start = mark_pos
    else
        let start = 1
    endif
    call setpos("'s", [0, start, 0, 0])
    mark r  " Update mark 'r'
    let code = getline(start, current)
    call SendCode(code, 'FALSE')
endfunction
nnoremap <expr> g, RunSection()
