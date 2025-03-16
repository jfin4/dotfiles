" https://github.com/spolu/dwm.vim Copyright (C) 2012 Stanislas Polu an other Contributors

" stack focused pane
function! DWM_Stack(on_top)
    1wincmd w
    if a:on_top
        wincmd K
    else
        wincmd J
    endif
endfunction

" focus pane
function! DWM_Focus()
    if winnr() == 1
        wincmd w
    endif
    let l:curwin = winnr()
    call DWM_Stack(1)
    exec l:curwin . "wincmd w"
    wincmd H
endfunction

" close window
function! DWM_Close()
    if winnr() == 1
        return 'bdelete! | call DWM_Focus()'
    else
        return 'bdelete!'
    end
endfunction

" move window
function! DWM_Move()
    if winnr() == winnr('$')
        call DWM_Stack(0)
        wincmd W
        call DWM_Focus()
    elseif winnr() == 1
        call DWM_Stack(1)
        wincmd W
        call DWM_Focus()
        wincmd w
    else
        wincmd x
        wincmd w
    endif
endfunction

" focus new window
function! DWM_FocusNew()
    " move new to top and go to focused
    wincmd K
    wincmd w
    " move focused to top and go back to new
    wincmd K
    wincmd w
    " focus new
    call DWM_Focus()
endfunction

" focus new windows
augroup dwm
    au!
    au BufWinEnter * call DWM_FocusNew()
augroup end

" map commands
nnoremap <silent> <c-,>     :call DWM_Move()<CR>
nnoremap <silent> <c-i>     :terminal<cr>
nnoremap <silent> <c-j>     :wincmd w<cr>
nnoremap <silent> <c-k>     :wincmd W<cr>
nnoremap <silent> <c-o>     :exec DWM_Close()<CR>
nnoremap <silent> <c-space> :call DWM_Focus()<CR>

tnoremap <silent> <c-,>     <c-w>:call DWM_Move()<CR>
tnoremap <silent> <c-i>     <c-w>:terminal<cr>
tnoremap <silent> <c-j>     <c-w>:wincmd w<cr>
tnoremap <silent> <c-k>     <c-w>:wincmd W<cr>
tnoremap <silent> <c-o>     <c-w>:exec DWM_Close()<CR>
tnoremap <silent> <c-space> <c-w>:call DWM_Focus()<CR>

