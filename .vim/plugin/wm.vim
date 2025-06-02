" inspo: https://github.com/spolu/dwm.vim

" stack windows
function! WmStack()
    for win in range(1, winnr('$'))
        1wincmd w
        wincmd J
        normal! zb
    endfor
endfunction

" focus window
function! WmFocus(win = winnr())
    call WmStack()
    execute a:win..'wincmd w'
    wincmd H
    normal! zb
endfunction

" zoom window
function! WmZoom()
    if !exists('b:return_tab')
        let b:return_tab = tabpagenr()
        tab split
    else
        execute 'tabclose'
        execute 'tabnext '..b:return_tab
        unlet b:return_tab
    endif
endfunction

" close window
function! WmClose()
    execute &buftype == 'terminal' ? 'quit!' : 'quit'
    call WmFocus(1)
endfunction

" handle new windows
augroup wm
    autocmd!
    autocmd BufWinEnter * call WmFocus(1)
augroup end

" maps
" nnoremap <silent> <c-i>         :terminal<cr>
nnoremap <silent> <c-j>         :wincmd w<cr>
nnoremap <silent> <c-k>         :wincmd W<cr>
" nnoremap <silent> <c-o>         :call WmClose()<CR>
nnoremap <silent> <c-space>     :call WmFocus()<CR>
nnoremap <silent> <nul>         :call WmFocus()<CR>
" tnoremap <silent> <c-i>         <c-w>:terminal<cr>
tnoremap <silent> <c-j>         <c-w>:wincmd w<cr>
tnoremap <silent> <c-k>         <c-w>:wincmd W<cr>
" tnoremap <silent> <c-o>         <c-w>:call WmClose()<CR>
tnoremap <silent> <c-space>     <c-w>:call WmFocus()<CR>
tnoremap <silent> <nul>         <c-w>:call WmFocus()<CR>
nnoremap <silent> <c-t>         :call WmZoom()<CR>
tnoremap <silent> <c-t>         <c-w>:call WmZoom()<CR>
