"/usr/share/vim/vim90/colors/README.txt
" help group-name highlight-groups cterm-colors
let colors_name = 'jfin'

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
let alert   = 'yellow'
let default = 'none'
let literal = 'cyan'
let loud    = 'black'       " bg
let louder  = 'darkgray'    " bg
let quiet   = 'gray'        " fg
let quieter = 'black'       " fg

" ['group', fg, bg, style]
let attributes_list = [
            \ ['comment', quiet], 
            \ ['constant', literal],
            \ ['string', literal], 
            \ ['character', literal],
            \ ['number', literal], 
            \ ['boolean', literal],
            \ ['float', literal], 
            \ ['error', default, alert],
            \ ['todo', default, alert], 
            \ ['added', default, louder],
            \ ['removed', quiet], 
            \ ['conceal', quiet],
            \ ['cursearch', default, louder], 
            \ ['diffadd', default, louder],
            \ ['diffdelete', quiet], 
            \ ['difftext', default, louder],
            \ ['endofbuffer', quiet], 
            \ ['folded', quiet],
            \ ['incsearch', default, louder], 
            \ ['linenr', quiet],
            \ ['matchparen', default, louder], 
            \ ['nontext', quiet],
            \ ['pmenu', default, loud], 
            \ ['pmenuextra', default, loud],
            \ ['pmenuextrasel', default, louder], 
            \ ['pmenukind', default, loud],
            \ ['pmenukindsel', default, louder], 
            \ ['pmenumatch', default, loud],
            \ ['pmenumatchsel', default, louder], 
            \ ['pmenusbar', default, loud],
            \ ['pmenusel', default, louder], 
            \ ['pmenuthumb', default, louder],
            \ ['popupnotification', default, loud], 
            \ ['search', default, louder],
            \ ['specialkey', quiet], 
            \ ['spellbad', default, alert],
            \ ['spellcap', default, alert], 
            \ ['spelllocal', default, alert],
            \ ['spellrare', default, alert], 
            \ ['statusline', quiet, loud],
            \ ['statuslinenc', quieter, loud], 
            \ ['statuslineterm', quiet, loud],
            \ ['statuslinetermnc', quieter, loud], 
            \ ['tabline', quieter, loud],
            \ ['tablinefill', quieter, loud], 
            \ ['tablinesel', quiet, loud],
            \ ['vertsplit', default, loud], 
            \ ['visual', default, louder],
            \ ['visualnos', default, louder], 
            \ ['wildmenu', default, louder]
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
