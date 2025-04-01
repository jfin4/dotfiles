" inspo: https://github.com/spolu/dwm.vim

" default layout
let g:wm_is_vertical = 1

" do something to window 1
function! WmWin1(func)
    let active_window = winnr()
    1wincmd w
    call call(a:func, [])
    execute active_window..'wincmd w'
endfunction

" stack windows
function! WmStack()
    for win in range(1, winnr('$'))
        if g:wm_is_vertical == 1
            wincmd J
        else
            wincmd L
        endif
        normal! zb
        1wincmd w
    endfor
endfunction

" focus window
function! WmFocus()
    call WmWin1('WmStack')
    if g:wm_is_vertical == 1
        wincmd H
    else
        wincmd K
    endif
    normal! zb
endfunction

" toggle layout
function! WmToggleLayout()
    let g:wm_is_vertical = g:wm_is_vertical == 1 ? 0 : 1
    call WmWin1('WmFocus')
endfunction

" close window
function! WmClose()
    if &buftype == 'terminal' 
        quit! 
    else
        quit
    endif
    call WmWin1('WmFocus')
endfunction

" handle new windows
augroup wm
    autocmd!
    autocmd BufWinEnter * call WmWin1('WmFocus')
augroup end

" maps
nnoremap <silent> <c-i>         :terminal<cr>
nnoremap <silent> <c-j>         :wincmd w<cr>
nnoremap <silent> <c-k>         :wincmd W<cr>
nnoremap <silent> <c-o>         :call WmClose()<CR>
nnoremap <silent> <c-space>     :call WmFocus()<CR>
nnoremap <silent> <c-,>         :call WmToggleLayout()<CR>
nnoremap <silent> <nul>         :call WmFocus()<CR>
tnoremap <silent> <c-i>         <c-w>:terminal<cr>
tnoremap <silent> <c-j>         <c-w>:wincmd w<cr>
tnoremap <silent> <c-k>         <c-w>:wincmd W<cr>
tnoremap <silent> <c-o>         <c-w>:call WmClose()<CR>
tnoremap <silent> <c-space>     <c-w>:call WmFocus()<CR>
tnoremap <silent> <c-,>         <c-w>:call WmToggleLayout()<CR>
tnoremap <silent> <nul>         <c-w>:call WmFocus()<CR>
