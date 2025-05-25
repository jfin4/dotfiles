" repl
function! OpenRepl()
    let term_command = {
                \ 'r': 'terminal R --quiet --no-save',
                \ 'python': 'terminal sh -c "./venv/bin/python || python"',
                \ 'sh': 'terminal', 
                \ }
    execute term_command[&filetype]
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

function! GetReplFile()
    let repl_file = printf('%s/.%s.repl', 
                \ expand('%:p:h'),
                \ expand('%:t:r'))
    if hostname() == "WB-102575"
        let repl_file = repl_file->substitute("^/c", "c:", "")
    endif
    return repl_file
endfunction

function! SendCode(code = [], echo = 1) abort
    if !exists('b:repl_buf')
        call SetReplBuf()
    endif
    let repl_file = GetReplFile()
    if !filereadable('repl_file')
        execute printf('autocmd VimLeavePre * call delete("%s")',
                    \ repl_file)
    endif
    call writefile(a:code, repl_file)
    if a:echo
        let source_command = {
                    \ 'r': 'suppressWarnings(suppressMessages(source("%s", echo = TRUE, max.deparse.length = Inf)))',
                    \ 'python': 'exec(open("%s").read())',
                    \ 'sh': 'source "%s"',
                    \ }
    else
        let source_command = {
                    \ 'r': 'suppressWarnings(suppressMessages(source("%s")))',
                    \ 'python': 'exec(open("%s").read())',
                    \ 'sh': 'source "%s"',
                    \ }
    endif
    let repl_command = printf(source_command[&filetype],
                \ repl_file)
    call term_sendkeys(b:repl_buf, repl_command . "\r")
endfunction

function! RunMotion(type = '') abort
    if a:type == ''
        let &operatorfunc = 'RunMotion'
        return 'g@'
    endif
    let selection = {
                \ 'line': "'[V']",
                \ 'char': "`[v`]",
                \ 'block': "`[\<C-V>`]",
                \ }[a:type]
    execute printf('normal! %s"ry',
                \ selection)
    if &filetype == 'vim'
        @r
    else
        call split(@r, "\n")->SendCode()
    endif
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
    " 0: echo = 0
    call SendCode(code, 0)
endfunction
nnoremap <expr> g, RunSection()
