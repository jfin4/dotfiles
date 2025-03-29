" repl
function! OpenRepl()
    terminal R --quiet --no-save
    let repl_buf = bufnr() 
    wincmd w
    call DWM_Focus()
    let b:repl_buf = repl_buf
    let g:repl_file = '.repl-code.r'
    execute 'autocmd BufDelete <buffer=' . repl_buf . '> '
                \ . 'call delete("' . g:repl_file . '")'
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

function! Run(code = [], echo = 'TRUE') abort
    call writefile(a:code, g:repl_file)
    let repl_command = printf(
        \ 'suppressWarnings(suppressMessages(source(max = Inf, echo = %s, "%s")))',
        \ a:echo,
        \ g:repl_file)
    call term_sendkeys(b:repl_buf, repl_command . "\r")
endfunction

function! RunMotion(type = '') abort
    if a:type == ''
        set operatorfunc=RunMotion
        return 'g@'
    endif
    let text = #{
                \ line: "'[V']",
                \ char: "`[v`]",
                \ block: "`[\<C-V>`]",
                \ }[a:type]
    execute 'normal! ' .. text .. '"ry'
    let code = split(@r, "\n")
    call Run(code)
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
    call Run(code, 'FALSE')
endfunction
nnoremap <expr> g, RunSection()
