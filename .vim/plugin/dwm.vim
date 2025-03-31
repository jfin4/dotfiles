" https://github.com/spolu/dwm.vim

" default layout
let g:wm_is_vertical = 1

" stack windows
function! WmStack()
    for win in range(1, winnr('$'))
        1wincmd w
        execute g:wm_is_vertical == 1 ? 'wincmd J' : 'wincmd L'
    endfor
    1wincmd w
endfunction

" save cursor position of main window
function! WmSaveCursor()
    1wincmd w 
    normal! mw
endfunction

" focus window
function! WmFocus(win = winnr())
    let orig_window = winnr()
    call WmSaveCursor()
    call WmStack()
    execute a:win..'wincmd w'
    execute g:wm_is_vertical == 1 ? 'wincmd H' : 'wincmd K'
    execute a:win == 1 ? orig_window..'wincmd w' : 'normal! `w'
endfunction

" toggle layout
function! WmToggleLayout()
    let g:wm_is_vertical = g:wm_is_vertical == 1 ? 0 : 1
    call WmFocus(1)
endfunction

" close window
function! WmClose()
    execute &buftype == 'terminal' ? 'quit!' : 'quit'
    call WmFocus(1)
endfunction

" handle new windows
augroup wm
    autocmd!
    autocmd WinNewPre * call WmSaveCursor()
    autocmd BufWinEnter * call WmStack() | call WmFocus(1)
augroup end

" maps
nnoremap <silent> <c-i>         :terminal<cr>
nnoremap <silent> <c-j>         :wincmd w<cr>
nnoremap <silent> <c-k>         :wincmd W<cr>
nnoremap <silent> <c-o>         :call WmClose()<CR>
nnoremap <silent> <c-space>     :call WmFocus()<CR>
nnoremap <silent> <c-u>         :call WmToggleLayout()<CR>
nnoremap <silent> <nul>         :call WmFocus()<CR>
tnoremap <silent> <c-i>         <c-w>:terminal<cr>
tnoremap <silent> <c-j>         <c-w>:wincmd w<cr>
tnoremap <silent> <c-k>         <c-w>:wincmd W<cr>
tnoremap <silent> <c-o>         <c-w>:call WmClose()<CR>
tnoremap <silent> <c-space>     <c-w>:call WmFocus()<CR>
tnoremap <silent> <c-u>         <c-w>:call WmToggleLayout()<CR>
tnoremap <silent> <nul>         <c-w>:call WmFocus()<CR>
