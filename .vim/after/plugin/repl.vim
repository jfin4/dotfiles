" repl
function! OpenREPL()
    vertical botright terminal ++close Rterm --quiet --no-save
    let buf = bufnr('%') 
    wincmd w 
    let b:repl_buf = buf
endfunction
command! OpenREPL call OpenREPL()
            
function! SetREPLPane(args) 
    let b:repl_buf = args
endfunction
command! -nargs=1 SetREPLPane call SetREPLPane(<args>)

function! CloseREPL() 
    execute 'bdelete! ' . b:repl_buf
    unlet b:repl_buf
endfunction
command! CloseREPL call CloseREPL()

function! SendCode(args) 
    if !exists('b:repl_buf')
        echo "set repl pane"
        return
    endif
    let code = get(a:args, 'code', '')
    let echo = get(a:args, 'echo', '')
    let file = 'c:/Users/jinman/Desktop/Final_ReLEP/ReLEP/temp-code.r'
    call writefile(code, file)
    let source_command = printf(
                \'suppressWarnings(suppressMessages(source(max = Inf, echo = %s, "%s")))',
                \echo, 
                \file)
    " Switch to REPL buffer and send input
    call term_sendkeys(b:repl_buf, source_command . "\r")
endfunction

function! RunLine() 
    " [] makes it a list, needed by writefile() in SendCode()
    let code = [ getline('.') ]
    let args = {'code': code, 'echo': 'TRUE'}
    call SendCode(args)
endfunction
nnoremap , :call RunLine()<CR>

function! RunSelection() range 
    normal! gv"xy
    let selection = @x
    let selection = split(selection, "\n")
    let args = {'code': selection, 'echo': 'TRUE'}
    call SendCode(args)
endfunction
xnoremap , :call RunSelection()<CR>

sign define start text=>> texthl=SignColumn
function! RunFile() 
    " get start sign
    let current = line('.')
    let buffer = bufnr('%')
    let start = 1
    let signs = sign_getplaced(buffer)
    if len(signs[0].signs) > 0
        " assuming there is at most one sign
        let sign = signs[0].signs[0].lnum 
        if sign < current
            let start = sign + 1
        endif
    endif
    " send code
    let code = getline(start, current)
    let args = {'code': code, 'echo': 'FALSE'}
    call SendCode(args)
    " shift start sign
    call sign_unplace('', {'buffer': buffer, 'name': 'start'})
    let b:sign = localtime()
    call sign_place(b:sign, 
                \'', 
                \'start', 
                \buffer, 
                \{'lnum': current, 'priority': 10})
    call setpos('''s', getpos('.'))
endfunction
nnoremap <leader>, :call RunFile()<CR>
