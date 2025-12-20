"/usr/share/vim/vim90/colors/README.txt
" help group-name highlight-groups cterm-colors
let colors_name = 'jfin'
set t_Co=16

" set attributes of all groups to none
redir => hloutput
silent highlight
redir END
for line in split(hloutput, "\n")
    if line =~# 'links to'  " Skip lines that define highlight links
        continue
    endif
    let group = matchstr(line, '^\S\+')
    if !empty(group)
        execute 'hi ' . group . ' ctermfg=none ctermbg=none cterm=none'
    endif
endfor

" colors named by function
let accented = 'cyan'
let alert   = 'brown' "bg
let border    = 'black' "bg
let default = 'none'
let muted   = 'gray'
let selected  = 'darkgray' "bg

" ['group', fg, bg, style]
let attributes_list = [
            \ ['comment', muted], 
            \ ['constant', accented],
            \ ['string', accented], 
            \ ['character', accented],
            \ ['number', accented], 
            \ ['boolean', accented],
            \ ['float', accented], 
            \ ['error', default, alert],
            \ ['todo', default, alert], 
            \ ['added', default, alert],
            \ ['removed', muted], 
            \ ['conceal', muted],
            \ ['cursearch', default, alert], 
            \ ['diffadd', default, alert],
            \ ['diffdelete', muted], 
            \ ['difftext', default, alert],
            \ ['endofbuffer', muted], 
            \ ['folded', muted],
            \ ['incsearch', default, alert], 
            \ ['linenr', muted],
            \ ['matchparen', default, alert], 
            \ ['nontext', border],
            \ ['pmenu', default, border], 
            \ ['pmenuextra', default, border],
            \ ['pmenuextrasel', default, selected], 
            \ ['pmenukind', default, border],
            \ ['pmenukindsel', default, selected], 
            \ ['pmenumatch', default, border],
            \ ['pmenumatchsel', default, selected], 
            \ ['pmenusbar', default, border],
            \ ['pmenusel', default, selected], 
            \ ['pmenuthumb', default, selected],
            \ ['popupnotification', default, border], 
            \ ['search', default, alert],
            \ ['specialkey', accented], 
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
            \ ['underlined', accented, default],
            \ ['vertsplit', default, border], 
            \ ['visual', default, alert],
            \ ['visualnos', default, alert], 
            \ ['wildmenu', default, selected]
            \]

" set highligh group attributes
for attributes in attributes_list
    let command = printf('highlight %s ctermfg=%s ctermbg=%s cterm=%s',
                \ attributes->get(0),
                \ attributes->get(1, default),
                \ attributes->get(2, default),
                \ attributes->get(3, default))
    execute command
endfor
