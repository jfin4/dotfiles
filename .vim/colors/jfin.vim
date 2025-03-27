" /usr/share/vim/vim90/colors/README.txt
" :help cterm-colors
" :help group-name
" :help highlight-groups

let colors_name = 'jfin'

set background=dark
set t_Co=16

" set all groups to none
redir => hloutput
silent highlight
redir END

for line in split(hloutput, "\n")
    if line =~# 'links to'  " Skip lines that define highlight links
        continue
    endif
    let group = matchstr(line, '^\S\+')
    if !empty(group)
        execute 'hi ' . group . ' ctermfg=NONE ctermbg=NONE cterm=NONE'
    endif
endfor

" apply colors to a highlight group
function! SetColors(group, ...)
    let group = a:group
    let fg    = a:000->get(0, 'NONE')
    let bg    = a:000->get(1, 'NONE')
    let style = a:000->get(2, 'NONE')

    let command = printf('highlight %s ctermfg=%s ctermbg=%s cterm=%s',
                \group,
                \fg,
                \bg,
                \style)

    execute command
endfunction

" define colors
let alert   = 'brown'
let default = 'none'
let literal = 'cyan'
let loud    = 'black'
let louder  = 'darkgray'
let quiet   = 'gray'
let quieter = 'black'

" SetColors(group, fg, bg, style)
call SetColors('comment', quiet)
call SetColors('constant', literal)
call SetColors('string', literal)
call SetColors('character', literal)
call SetColors('number', literal)
call SetColors('boolean', literal)
call SetColors('float', literal)
call SetColors('error', default, alert)
call SetColors('todo', default, alert)
call SetColors('added', default, louder)
call SetColors('removed', quiet)
call SetColors('conceal', quiet)
call SetColors('cursearch', louder)
call SetColors('diffadd', default, louder)
call SetColors('diffdelete', quiet)
call SetColors('difftext', default, louder)
call SetColors('endofbuffer', quiet)
call SetColors('folded', quiet)
call SetColors('incsearch', default, louder)
call SetColors('linenr', quiet)
call SetColors('matchparen', default, louder)
call SetColors('nontext', quiet)
call SetColors('pmenu', default, loud)
call SetColors('pmenuextra', default, loud)
call SetColors('pmenuextrasel', default, louder)
call SetColors('pmenukind', default, loud)
call SetColors('pmenukindsel', default, louder)
call SetColors('pmenumatch', default, loud)
call SetColors('pmenumatchsel', default, louder)
call SetColors('pmenusbar', default, loud)
call SetColors('pmenusel', default, louder)
call SetColors('pmenuthumb', default, louder)
call SetColors('popupnotification', default, loud)
call SetColors('search', default, louder)
call SetColors('specialkey', quiet)
call SetColors('spellbad', default, alert)
call SetColors('spellcap', default, alert)
call SetColors('spelllocal', default, alert)
call SetColors('spellrare', default, alert)
call SetColors('statusline', quiet, loud)
call SetColors('statuslinenc', quieter, loud)
call SetColors('statuslineterm', quiet, loud)
call SetColors('statuslinetermnc', quieter, loud)
call SetColors('tabline', quieter, loud)
call SetColors('tablinefill', quieter, loud)
call SetColors('tablinesel', quiet, loud)
call SetColors('vertsplit', default, loud)
call SetColors('visual', default, louder)
call SetColors('visualnos', default, louder)
call SetColors('wildmenu', default, louder)
