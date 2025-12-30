" repl
function! OpenRepl()
    let term_commands = {
                \ 'r': 'R --quiet --no-save',
                \ 'python': './.venv/bin/python || python',
                \ 'sql': 'sqlite3',
                \ }
    let term_command = get(term_commands, &filetype, '')
    let tmux_command = printf('tmux split-window -d -h -P -F "#{pane_id}" %s\; select-layout main-vertical',
                \ term_command)
    let b:repl_pane = system(tmux_command)->substitute('\n$', '', '')
endfunction
command! OpenRepl call OpenRepl()

function! CloseRepl()
    let close_commands = {
                \ 'r': 'quit()',
                \ 'python': 'quit()',
                \ 'sql': '.exit',
                \ }
    let code = [get(close_commands, &filetype, 'exit')]
    call SendCode(code, 0)
endfunction
command! CloseRepl call CloseRepl()

function! SetReplPane()
    let tmux_command = 'tmux display-panes -d 5000 ''display-message -p -l %%'''
    let b:repl_pane = system(tmux_command)->substitute('\n$', '', '')
endfunction
command! SetReplPane call SetReplPane()

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
    if !exists('b:repl_pane')
        " call SetReplBuf()
        call SetReplPane()
    endif
    let repl_file = GetReplFile()
    if !filereadable('repl_file')
        execute printf('autocmd VimLeavePre * call delete("%s")',
                    \ repl_file)
    endif
    call writefile(a:code, repl_file)
    if a:echo
        let term_commands = {
                    \ 'r': 'suppressMessages(source("%s", echo = TRUE, max.deparse.length = Inf))',
                    \ 'python': 'exec(open("%s").read())',
                    \ 'sql': '.read %s',
                    \ }
    else
        let term_commands = {
                    \ 'r': 'suppressMessages(source("%s"))',
                    \ 'python': 'exec(open("%s").read())',
                    \ 'sql': '.read %s',
                    \ }
    endif
    let term_command = printf(get(term_commands, &filetype, 'source "%s"'),
                \ repl_file)
    let repl_command = printf('tmux send-keys -t %s ''%s'' Enter',
                \ b:repl_pane,
                \ term_command)
    call system(repl_command)
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
