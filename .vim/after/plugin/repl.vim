" repl
function! OpenREPL()
    if &filetype == 'r'
        let interpreter = 'Rterm --quiet --no-save'
    else
        let interpreter = 'zsh' " Default to shell if no filetype match
    endif
    let command = printf('tmux split-window -d -h -P -F "#{pane_id}" %s', 
                \interpreter)
    let b:pane = system(command)->substitute('\n$', '', '')
endfunction
command! OpenREPL call OpenREPL()

function! SetREPLPane() 
    let command = 'tmux display-panes -d 5000 ''display-message -p -l %%'''
    let b:pane = system(command)->substitute('\n$', '', '')
endfunction
command! SetREPLPane call SetREPLPane()

function! CloseREPL() 
    let command = printf('tmux kill-pane -t %s', b:pane)
    call system(command)
endfunction
command! CloseREPL call CloseREPL()

function! SendCode(args) 
    let code = get(a:args, 'code', '')
    let echo = get(a:args, 'echo', '')
    if &filetype == 'r'
        let file = 'c:/Users/jinman/Desktop/Final_ReLEP/ReLEP/temp-code.r'
        call writefile(code, file)
        " let inner_command = printf('qsource("%s", echo = %s)', file, echo)
        let inner_command = printf(
                    \'suppressWarnings(suppressMessages(source(
                    \max = Inf, 
                    \echo = %s,
                    \    "%s")))', echo, file)
    else
        let file = tempname()
        call writefile(code, file)
        let inner_command = printf('source %s', file)
    endif
    " used escaped single quotes to avoid closing by double quotes 
    " in inner_command
    let command = printf('tmux send-keys -t %s ''%s'' Enter', 
                \b:pane, 
                \inner_command)
    call system(command)
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
