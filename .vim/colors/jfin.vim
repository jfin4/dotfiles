"/usr/share/vim/vim90/colors/README.txt
" help group-name highlight-groups cterm-colors
let colors_name = 'jfin'
set t_Co=16

" set attributes of all groups to none{{{
" redir => hloutput
" silent highlight
" redir END
" for line in split(hloutput, "\n")
"     if line =~# 'links to'  " Skip lines that define highlight links
"         continue
"     endif
"     let group = matchstr(line, '^\S\+')
"     if !empty(group)
"         execute 'hi ' . group . ' ctermfg=none ctermbg=none cterm=none'
"     endif
" endfor
"}}}

" colors named by function
let accented = 'cyan'
let alert   = 'brown' "bg
let border    = 'black' "bg
let default = 'none'
let muted   = 'gray'
let selected  = 'darkgray' "bg

" assign colors{{{
" ['group', fg, bg, style]
let attributes_list = [
            \ ['comment', muted, default], 
            \ ['constant', accented, default],
            \ ['string', accented, default],
            \ ['character', accented, default],
            \ ['number', accented, default],
            \ ['boolean', accented, default],
            \ ['float', accented, default],
            \ ['identifier', default, default],
            \ ['function', default, default],
            \ ['statement', default, default],
            \ ['conditional', default, default],
            \ ['repeat', default, default],
            \ ['label', default, default],
            \ ['operator', default, default],
            \ ['keyword', default, default],
            \ ['exception', default, default],
            \ ['preproc', default, default],
            \ ['include', default, default],
            \ ['define', default, default],
            \ ['macro', default, default],
            \ ['precondit', default, default],
            \ ['type', default, default],
            \ ['storageclass', default, default],
            \ ['structure', default, default],
            \ ['typedef', default, default],
            \ ['special', default, default],
            \ ['specialchar', default, default],
            \ ['tag', default, default],
            \ ['delimiter', default, default],
            \ ['specialcomment', default, default],
            \ ['debug', default, default],
            \ ['underlined', accented, default],
            \ ['bold', accented, default],
            \ ['italic', accented, default],
            \ ['bolditalic', accented, default],
            \ ['ignore', default, default],
            \ ['error', default, alert],
            \ ['todo', default, alert],
            \ ['added', default, alert],
            \ ['changed', default, alert],
            \ ['removed', muted, default],
            \ ['colorcolumn', default, default],
            \ ['conceal', muted, default],
            \ ['cursor', default, default],
            \ ['lcursor', default, default],
            \ ['cursorim', default, default],
            \ ['cursorcolumn', default, default],
            \ ['cursorline', default, default],
            \ ['directory', default, default],
            \ ['diffadd', default, alert],
            \ ['diffchange', default, default],
            \ ['diffdelete', muted, default], 
            \ ['difftext', default, alert],
            \ ['difftextadd', default, default],
            \ ['endofbuffer', muted, default], 
            \ ['errormsg', default, default],
            \ ['vertsplit', default, border],
            \ ['folded', muted, default],
            \ ['foldcolumn', default, default],
            \ ['signcolumn', default, default],
            \ ['incsearch', default, alert],
            \ ['linenr', muted, default],
            \ ['linenrabove', default, default],
            \ ['linenrbelow', default, default],
            \ ['cursorlinenr', default, default],
            \ ['cursorlinefold', default, default],
            \ ['cursorlinesign', default, default],
            \ ['matchparen', default, alert],
            \ ['messagewindow', default, default],
            \ ['modemsg', default, default],
            \ ['msgarea', default, default],
            \ ['moremsg', default, default],
            \ ['nontext', muted, default],
            \ ['normal', default, default],
            \ ['pmenu', default, border],
            \ ['pmenusel', default, selected],
            \ ['pmenukind', default, border],
            \ ['pmenukindsel', default, selected],
            \ ['pmenuextra', default, border],
            \ ['pmenuextrasel', default, selected],
            \ ['pmenusbar', default, border],
            \ ['pmenuthumb', default, selected],
            \ ['pmenumatch', default, border],
            \ ['pmenumatchsel', default, selected],
            \ ['pmenuborder', default, default],
            \ ['pmenushadow', default, default],
            \ ['complmatchins', default, default],
            \ ['preinsert', default, default],
            \ ['popupselected', default, default],
            \ ['popupnotification', default, border],
            \ ['question', default, default],
            \ ['quickfixline', default, default],
            \ ['search', default, alert],
            \ ['cursearch', default, alert], 
            \ ['specialkey', accented, default],
            \ ['spellbad', default, alert],
            \ ['spellcap', default, alert],
            \ ['spelllocal', default, alert],
            \ ['spellrare', default, alert],
            \ ['statusline', muted, border],
            \ ['statuslinenc', border, border],
            \ ['statuslineterm', muted, border],
            \ ['statuslinetermnc', border, border],
            \ ['tabline', border, border],
            \ ['tablinefill', border, border],
            \ ['tablinesel', muted, border],
            \ ['tabpanel', default, default],
            \ ['tabpanelfill', default, default],
            \ ['tabpanelsel', default, default],
            \ ['terminal', default, default],
            \ ['title', default, default],
            \ ['titlebar', default, default],
            \ ['titlebarnc', default, default],
            \ ['visual', default, alert],
            \ ['visualnos', default, alert],
            \ ['warningmsg', default, default],
            \ ['wildmenu', default, selected],
            \ ]
"}}}

"set highligh group attributes                                         
for attributes in attributes_list                                      
    let command = printf('highlight %s ctermfg=%s ctermbg=%s cterm=%s',  
                \ attributes->get(0),                                    
                \ attributes->get(1, default),                           
                \ attributes->get(2, default),                           
                \ attributes->get(3, default))                           
    execute command                                                   
endfor                                                               


