" https://github.com/spolu/dwm.vim

" default layout
let g:wm_is_vertical = 1

" stack windows
function! WmStack()
    let cur_win = winnr()
    for win in range(1, winnr('$'))
        1wincmd w
        execute g:wm_is_vertical == 1 ? 'wincmd J' : 'wincmd L'
    endfor
    1wincmd w
    execute cur_win..'wincmd w'
endfunction

" save cursor position of main window, assumes scrollkeep=topline
function! WmSaveCursor()
    let cur_win = winnr()
    1wincmd w 
    normal! mw
    execute cur_win..'wincmd w'
endfunction

" focus window
function! WmFocus()
    call WmSaveCursor()
    call WmStack()
    execute g:wm_is_vertical == 1 ? 'wincmd H' : 'wincmd K'
    execute getpos('`w')[1] ? 'normal! `w' : ''
endfunction

" restore layout
function! WmRestoreLayout()
    let cur_win = winnr()
    1wincmd w
    call WmFocus()
    execute cur_win..'wincmd w'
endfunction

" toggle layout
function! WmToggleLayout()
    let g:wm_is_vertical = g:wm_is_vertical == 1 ? 0 : 1
    call WmRestoreLayout()
endfunction

" close window
function! WmClose()
    execute &buftype == 'terminal' ? 'quit!' : 'quit'
    call WmRestoreLayout()
endfunction

" handle new windows
augroup wm
    autocmd!
    " should be WinNewPre
    autocmd WinLeave * call WmSaveCursor()
    autocmd BufWinEnter * call WmRestoreLayout()
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
