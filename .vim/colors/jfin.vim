" see /usr/share/vim/vim90/colors/README.txt
set background=dark
let colors_name = "jfin"

" function to apply colors to a highlight group using a dictionary for named arguments
function! Hl(group, args)
    " Set default values for foreground (fg), background (bg), and gui if not provided
    let fg = has_key(a:args, 'fg') ? a:args.fg : 'none'
    let bg = has_key(a:args, 'bg') ? a:args.bg : 'none'
    let style = has_key(a:args, 'style') ? a:args.style : 'none'

    " Apply the highlight group using the dictionary arguments
    let cmd = printf('highlight %s ctermfg=%s ctermbg=%s cterm=%s',
                \a:group,
                \fg,
                \bg,
                \style)

    execute cmd
endfunction

" normal
call Hl('normal',         { 'fg': 'none'})

" :help group-name

call Hl('comment',        { 'fg': 'lightgray'})

call Hl('constant',       { 'fg': 'blue'})
call Hl('string',         { 'fg': 'blue'})
call Hl('character',      { 'fg': 'blue'})
call Hl('number',         { 'fg': 'blue'})
call Hl('boolean',        { 'fg': 'blue'})
call Hl('float',          { 'fg': 'blue'})

call Hl('identifier',     { 'fg': 'none'})
call Hl('function',       { 'fg': 'none'})

call Hl('statement',      { 'fg': 'none'})
call Hl('conditional',    { 'fg': 'none'})
call Hl('repeat',         { 'fg': 'none'})
call Hl('label',          { 'fg': 'none'})
call Hl('operator',       { 'fg': 'none'})
call Hl('keyword',        { 'fg': 'none'})
call Hl('exception',      { 'fg': 'none'})

call Hl('preproc',        { 'fg': 'none'})
call Hl('include',        { 'fg': 'none'})
call Hl('define',         { 'fg': 'none'})
call Hl('macro',          { 'fg': 'none'})
call Hl('precondit',      { 'fg': 'none'})

call Hl('type',           { 'fg': 'none'})
call Hl('storageclass',   { 'fg': 'none'})
call Hl('structure',      { 'fg': 'none'})
call Hl('typedef',        { 'fg': 'none'})

call Hl('special',        { 'fg': 'none'})
call Hl('specialchar',    { 'fg': 'none'})
call Hl('tag',            { 'fg': 'none'})
call Hl('delimiter',      { 'fg': 'none'})
call Hl('specialcomment', { 'fg': 'none'})
call Hl('debug',          { 'fg': 'none'})

call Hl('underlined',     { 'style': 'underline'})

call Hl('ignore',         { 'fg': 'none'})

call Hl('error',          { 'fg': 'red'})

call Hl('todo',           { 'fg': 'black', 'bg': 'yellow', 'style': 'bold'})

call Hl('added',          { 'bg': 'none'})
call Hl('changed',        { 'fg': 'none'})
call Hl('removed',        { 'fg': 'lightgray'})

" :help highlight-groups
call Hl('colorcolumn',       { 'fg': 'none'})
call Hl('conceal',           { 'fg': 'lightgray'})
call Hl('cursearch',         { 'fg': 'black', 'bg': 'yellow', 'style': 'bold'})
call Hl('cursor',            { 'fg': 'none'})
call Hl('cursorcolumn',      { 'fg': 'none'})
call Hl('cursorim',          { 'fg': 'none'})
call Hl('cursorline',        { 'fg': 'none'})
call Hl('cursorlinefold',    { 'fg': 'none'})
call Hl('cursorlinenr',      { 'fg': 'none'})
call Hl('cursorlinesign',    { 'fg': 'none'})
call Hl('diffadd',           { 'fg': 'black', 'bg': 'yellow', 'style': 'bold'})
call Hl('diffchange',        { 'fg': 'none'})
call Hl('diffdelete',        { 'fg': 'lightgray'})
call Hl('difftext',          { 'fg': 'black', 'bg': 'yellow', 'style': 'bold'})
call Hl('directory',         { 'fg': 'none'})
call Hl('endofbuffer',       { 'fg': 'lightgray'})
call Hl('errormsg',          { 'fg': 'red'})
call Hl('foldcolumn',        { 'fg': 'none'})
call Hl('folded',            { 'fg': 'lightgray'})
call Hl('incsearch',         { 'fg': 'black', 'bg': 'yellow', 'style': 'bold'})
call Hl('lcursor',           { 'fg': 'none'})
call Hl('linenr',            { 'fg': 'lightgray'})
call Hl('linenrabove',       { 'fg': 'none'})
call Hl('linenrbelow',       { 'fg': 'none'})
call Hl('matchparen',        { 'fg': 'black', 'bg': 'yellow', 'style': 'bold'})
call Hl('messagewindow',     { 'fg': 'lightgray'})
call Hl('modemsg',           { 'fg': 'lightgray'})
call Hl('moremsg',           { 'fg': 'none'})
call Hl('msgarea',           { 'fg': 'none'})
call Hl('nontext',           { 'fg': 'lightgray'})
call Hl('pmenu',             { 'bg': 'darkgray', 'style': 'bold'})
call Hl('pmenuextra',        { 'bg': 'darkgray', 'style': 'bold'})
call Hl('pmenuextrasel',     { 'bg': 'lightgray', 'style': 'bold'})
call Hl('pmenukind',         { 'bg': 'darkgray', 'style': 'bold'})
call Hl('pmenukindsel',      { 'bg': 'lightgray', 'style': 'bold'})
call Hl('pmenumatch',        { 'bg': 'darkgray', 'style': 'bold'})
call Hl('pmenumatchsel',     { 'bg': 'lightgray', 'style': 'bold'})
call Hl('pmenusbar',         { 'bg': 'darkgray', 'style': 'bold'})
call Hl('pmenusel',          { 'bg': 'lightgray', 'style': 'bold'})
call Hl('pmenuthumb',        { 'bg': 'lightgray', 'style': 'bold'})
call Hl('popupnotification', { 'bg': 'lightgray'})
call Hl('question',          { 'fg': 'none'})
call Hl('quickfixline',      { 'fg': 'none'})
call Hl('search',            { 'fg': 'black', 'bg': 'yellow', 'style': 'bold'})
call Hl('signcolumn',        { 'fg': 'none'})
call Hl('specialkey',        { 'fg': 'lightgray'})
call Hl('spellbad',          { 'fg': 'red'})
call Hl('spellcap',          { 'fg': 'red'})
call Hl('spelllocal',        { 'fg': 'red'})
call Hl('spellrare',         { 'fg': 'red'})
call Hl('statusline',        { 'fg': 'lightgray'})
call Hl('statuslinenc',      { 'fg': 'lightgray'})
call Hl('statuslineterm',    { 'fg': 'lightgray'})
call Hl('statuslinetermnc',  { 'fg': 'lightgray'})
call Hl('tabline',           { 'fg': 'lightgray'})
call Hl('tablinefill',       { 'fg': 'lightgray'})
call Hl('tablinesel',        { 'fg': 'lightgray'})
call Hl('terminal',          { 'fg': 'none'})
call Hl('title',             { 'fg': 'none'})
call Hl('vertsplit',         { 'fg': 'darkgray'})
call Hl('visual',            { 'fg': 'black', 'bg': 'yellow', 'style': 'bold'})
call Hl('visualnos',         { 'fg': 'black', 'bg': 'yellow', 'style': 'bold'})
call Hl('warningmsg',        { 'fg': 'red'})
call Hl('wildmenu',          { 'bg': 'darkgray', 'style': 'bold'})
