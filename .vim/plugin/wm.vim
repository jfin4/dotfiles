" inspo: https://github.com/spolu/dwm.vim

" default layout
let g:wm_is_vertical = 1

" focus window
function! WmFocus()
    call WmKeepActive('WmSaveCursor')
    call WmKeepActive('WmStack')
    execute g:wm_is_vertical == 1 ? 'wincmd H' : 'wincmd K'
    execute getpos("'w")[1] ? 'normal! `w' : ''
endfunction

" stack windows
function! WmStack()
    for win in range(1, winnr('$'))
        execute g:wm_is_vertical == 1 ? 'wincmd J' : 'wincmd L'
        1wincmd w
    endfor
endfunction

" required due to scrollkeep=topline
function! WmSaveCursor()
    normal! mw
endfunction

" wrapper to keep active window
function! WmKeepActive(func)
    let active_window = winnr()
    1wincmd w
    call call(a:func, [])
    execute active_window..'wincmd w'
endfunction

" restore layout
function! WmRestoreLayout()
    call WmKeepActive('WmFocus')
endfunction

" toggle layout
function! WmToggleLayout()
    let g:wm_is_vertical = g:wm_is_vertical == 1 ? 0 : 1
    call WmKeepActive('WmRestoreLayout')
endfunction

" close window
function! WmClose()
    execute &buftype == 'terminal' ? 'quit!' : 'quit'
    call WmKeepActive('WmRestoreLayout')
endfunction

" handle new windows
augroup wm
    autocmd!
    autocmd CmdlineEnter * call WmKeepActive('WmSaveCursor')
    autocmd BufWinEnter * call WmKeepActive('WmRestoreLayout')
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
