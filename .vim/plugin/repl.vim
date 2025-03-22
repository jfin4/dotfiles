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
    let b:repl_buf = input("\nEnter REPL buffer number: ")->str2nr()
endfunction
command! SetReplBuf call SetReplBuf()

function! GetLine() abort
    " Run current line
     return [getline('.')]
endfunction

function! GetSection() abort
    " Run from last mark 'r' to current line
    let mark_pos = getpos("'r")
    let current = line('.')
    if mark_pos[1] < current
        let start = mark_pos[1]
    else
        let start = 1
    endif
    mark r  " Update mark 'r'
    return getline(start, current)
endfunction

function! GetSelection() abort
    " Visual code
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    normal! gvy
    let code = split(@", "\n")
    call setreg('"', old_reg, old_regtype)
    return code
endfunction

function! GetMotion(type) abort
    " Motion-based code (from operator)
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    if a:type ==# "char"
        normal! `[v`]y
    elseif a:type ==# "line"
        normal! `[V`]y
    elseif a:type ==# "block"
        normal! `[\<C-V>`]y
    endif
    let code = split(@", "\n")
    call setreg('"', old_reg, old_regtype)
    return code
endfunction

function! GetTextObject(text_object) abort
    " Use text object
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    execute 'normal! yi' . a:text_object
    let code = split(@", "\n")
    call setreg('"', old_reg, old_regtype)
    return code
endfunction

function! GetCode(from, ...) abort
    " first arg must be 'type' to work with motions
    " see help g@
    if a:from ==# 'line'
        let code = GetLine()
    elseif a:from ==# 'section'
        let code = GetSection()
    elseif a:from ==# 'selection'
        let code = GetSelection()
    elseif a:from ==# 'motion'
        let code = GetMotion(a:1)
    elseif a:from ==# 'text_object'
        let code = GetTextObject(a:1)
    else
        echo 'no code'
        return
    endif

    let verbose = ['line', 'selection', 'motion', 'text_object']
    if index(verbose, a:from) >= 0 
        let echo = 'TRUE'
    else
        let echo = 'FALSE'
    endif

    return {'code': code, 'echo': echo}
endfunction

function! RunCode(code) abort
    " code arg: {'code': [code], 'echo': 'TRUE' | 'FALSE'}
    if !exists('g:repl_file')
        let g:repl_file = 'repl-code.r'
    endif
    call writefile(a:code['code'], g:repl_file)
    let repl_command = printf(
                \'suppressWarnings(suppressMessages(source(max = Inf, echo = %s, "%s")))',
                \ a:code['echo'],
                \ g:repl_file)

    if !exists('b:repl_buf')
        call SetReplBuf()
    endif
    call term_sendkeys(b:repl_buf, repl_command . "\r")
endfunction

function! RunCodeMap(getter, ...) abort
    " Get the code based on the getter type
    let code = call('GetCode', [a:getter] + a:000)
    call RunCode(code)
    
    " Set up for repeat based on which function was called
    if a:getter ==# 'line'
        silent! call repeat#set("\<Plug>RunCodeLine", v:count)
    elseif a:getter ==# 'section'
        silent! call repeat#set("\<Plug>RunCodeSection", v:count)
    elseif a:getter ==# 'selection'
        " Visual mode is handled differently
    elseif a:getter ==# 'text_object'
        if a:1 ==# 'p'
            silent! call repeat#set("\<Plug>RunCodeTextObjectP", v:count)
        elseif a:1 ==# 'w'
            silent! call repeat#set("\<Plug>RunCodeTextObjectW", v:count)
        elseif a:1 ==# '{'
            silent! call repeat#set("\<Plug>RunCodeTextObjectCurly", v:count)
        endif
    endif
endfunction

function! RunCodeOp(type) abort
    let code = GetCode('motion', a:type)
    call RunCode(code)
    " allow . repeat
    silent! call repeat#set("\<Plug>RunCodeMotion", v:count)
endfunction

" Define <Plug> mappings - each needs a unique name
nnoremap <silent> <Plug>RunCodeLine           :call RunCodeMap('line')<CR>
nnoremap <silent> <Plug>RunCodeSection        :call RunCodeMap('section')<CR>
xnoremap <silent> <Plug>RunCodeSelection      :<C-U>call RunCodeMap('selection')<CR>
nnoremap <silent> <Plug>RunCodeTextObjectP    :call RunCodeMap('text_object', 'p')<CR>
nnoremap <silent> <Plug>RunCodeTextObjectW    :call RunCodeMap('text_object', 'w')<CR>
nnoremap <silent> <Plug>RunCodeTextObjectCurly :call RunCodeMap('text_object', '{')<CR>
nnoremap <silent> <Plug>RunCodeMotion         :set opfunc=RunCodeOp<CR>g@

" Map your actual key sequences to the <Plug> mappings
nnoremap <silent> ,,    <Plug>RunCodeLine 
nnoremap <silent> g,    <Plug>RunCodeSection   
xnoremap <silent> ,     <Plug>RunCodeSelection 
nnoremap <silent> ,ip   <Plug>RunCodeTextObjectP
nnoremap <silent> ,iw   <Plug>RunCodeTextObjectW
nnoremap <silent> ,i{   <Plug>RunCodeTextObjectCurly
nnoremap <silent> ,     <Plug>RunCodeMotion
