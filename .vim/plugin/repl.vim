function! GetReplArgs()
    if &filetype == 'R'
        let b:args = { 
                    \ 'term_command': 'terminal R --quiet --no-save',
                    \ 'source_command': 'suppressWarnings(suppressMessages(source("%s")))',
                    \ }
    elseif &filetype == 'python'
        " first %s is unuse echo command
        let b:args = { 
                    \ 'term_command': 'terminal sh -c "./venv/bin/python || python"',
                    \ 'source_command': 'exec(open("%s").read())',
                    \ }

    else
        " first %s is unuse echo command
        let b:args = { 
                    \ 'term_command': 'terminal', 
                    \ 'source_command': 'source "%s"',
                    \ }
    endif
endfunction

" repl
function! OpenRepl()
    call GetReplArgs()
    execute b:args.term_command
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

    call GetReplArgs()
endfunction
command! SetReplBuf call SetReplBuf()

function! SendCode(code = []) abort
    if !exists('b:repl_buf')
        call SetReplBuf()
    endif
    let repl_file = printf('%s/.%s.repl', 
                \ expand('%:p:h'),
                \ expand('%:t:r'))
    if hostname() == "WB-102575"
        let repl_file = repl_file->substitute("^/c", "c:", "")
    endif
    if !filereadable('repl_file')
        execute printf('autocmd VimLeavePre * call delete("%s")',
                    \ repl_file)
    endif
    call writefile(a:code, repl_file)
    let repl_command = printf(b:args.source_command,
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
    let code = split(@r, "\n")
    call SendCode(code)
endfunction
nnoremap <expr> <leader> RunMotion()
xnoremap <expr> <leader> RunMotion()
nnoremap <expr> <leader><leader> RunMotion() .. '_'

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
    call SendCode(code)
endfunction
nnoremap <expr> g, RunSection()
