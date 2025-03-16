" repl
let s:temp_file = 'repl-code.r'

function! OpenRepl()
    terminal R --quiet --no-save
    let repl_buf = bufnr() 
    wincmd w
    call DWM_Focus()
    let b:repl_buf = repl_buf
endfunction
command! OpenRepl call OpenRepl()
            
function! SetReplPane(arg) 
    let b:repl_buf = a:arg
endfunction
command! -nargs=1 SetReplPane call SetReplPane(<args>)

function! CloseRepl() 
    execute 'bdelete! ' . b:repl_buf
    unlet b:repl_buf
    call delete(s:temp_file)
endfunction
command! CloseRepl call CloseRepl()

function! SendCode(args) 
    if !exists('b:repl_buf')
        echo "set repl pane"
        return
    endif
    let code = get(a:args, 'code', '')
    let echo = get(a:args, 'echo', '')
    call writefile(code, s:temp_file)
    let source_command = printf(
                \'suppressWarnings(suppressMessages(source(max = Inf, echo = %s, "%s")))',
                \echo, 
                \s:temp_file)
    " Switch to Repl buffer and send input
    call term_sendkeys(b:repl_buf, source_command . "\r")
endfunction

function! RunLine() 
    " [] makes it a list, needed by writefile() in SendCode()
    let code = [ getline('.') ]
    let args = {'code': code, 'echo': 'TRUE'}
    call SendCode(args)
endfunction
nnoremap ,, :call RunLine()<CR>

" Add text object mappings
function! RunTextObject(textobj)
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    execute 'normal! yi' . a:textobj
    let selection = split(@", "\n")
    let args = {'code': selection, 'echo': 'TRUE'}
    call SendCode(args)
    call setreg('"', old_reg, old_regtype)
endfunction
nnoremap ,ip :call <SID>RunTextObject('p')<CR>
nnoremap ,iw :call <SID>RunTextObject('w')<CR>
nnoremap ,i{ :call <SID>RunTextObject('{')<CR>

function! RunSelection() range 
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    normal! gvy
    let selection = split(@", "\n")
    let args = {'code': selection, 'echo': 'TRUE'}
    call SendCode(args)
    call setreg('"', old_reg, old_regtype)
endfunction
xnoremap , :call RunSelection()<CR>

function! RunFile() 
    " get start from mark r
    let current = line('.')
    let start = 1
    let mark_pos = getpos("'r")
    if mark_pos[1] > 0 && mark_pos[1] < current
        let start = mark_pos[1] + 1
    endif
    " send code
    let code = getline(start, current)
    let args = {'code': code, 'echo': 'FALSE'}
    call SendCode(args)
    " update mark r
    mark r
endfunction
nnoremap <leader>, :call RunFile()<CR>
