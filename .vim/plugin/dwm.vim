" https://github.com/spolu/dwm.vim 

" focus window
function! DWM_Focus()
    if winnr() == 1
        wincmd w
    endif
    let l:curwin = winnr()
    1wincmd w
        wincmd K
    exec l:curwin . "wincmd w"
    wincmd H
    normal! zz
endfunction
nnoremap <silent> <c-space> :call DWM_Focus()<CR>
nnoremap <silent> <nul>     :call DWM_Focus()<CR>
tnoremap <silent> <c-space> <c-w>:call DWM_Focus()<CR>
tnoremap <silent> <nul>     <c-w>:call DWM_Focus()<CR>

" close window
function! DWM_Close()
    if &buftype == 'terminal'
        quit!
    else
        quit " autowrite
    endif
    if winnr() == 1
        wincmd H
    endif
endfunction
tnoremap <silent> <c-o>     <c-w>:exec DWM_Close()<CR>
nnoremap <silent> <c-o>     :exec DWM_Close()<CR>

" autocommand for new windows
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
augroup dwm
    autocmd!
    autocmd BufWinEnter * call DWM_FocusNew()
augroup end

" maps
nnoremap <silent> <c-i>     :terminal<cr>
tnoremap <silent> <c-i>     <c-w>:terminal<cr>
nnoremap <silent> <c-j>     :wincmd w<cr>
nnoremap <silent> <c-k>     :wincmd W<cr>
tnoremap <silent> <c-j>     <c-w>:wincmd w<cr>
tnoremap <silent> <c-k>     <c-w>:wincmd W<cr>

