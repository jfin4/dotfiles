let R_external_term = 1
let R_app = 'C:\Users\JInman\AppData\Local\Programs\R\R-4.2.3\bin\x64\Rgui.exe'

inoremap <buffer> , <Plug>RDSendLine
inoremap <buffer> < <-
inoremap <buffer> << <
inoremap <buffer> > %>%
inoremap <buffer> >> >
nnoremap <buffer> K :execute 'RSend ?' . expand('<cword>')<cr>
xnoremap <buffer> , <Plug>RDSendSelection
