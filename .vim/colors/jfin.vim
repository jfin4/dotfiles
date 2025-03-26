" about colorschemes: /usr/share/vim/vim90/colors/README.txt
set background=dark
set t_Co=16
let colors_name = 'jfin'

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

" :help cterm-colors
" :help group-name

call Hl('comment',        { 'fg': 'gray'})

call Hl('constant',       { 'fg': 'cyan'})
call Hl('string',         { 'fg': 'cyan'})
call Hl('character',      { 'fg': 'cyan'})
call Hl('number',         { 'fg': 'cyan'})
call Hl('boolean',        { 'fg': 'cyan'})
call Hl('float',          { 'fg': 'cyan'})

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

call Hl('ignore',         { 'fg': 'gray'})

call Hl('error',          { 'fg': 'black', 'bg': 'red'})

call Hl('todo',           { 'fg': 'black', 'bg': 'gray'})

call Hl('added',          { 'fg': 'black', 'bg': 'gray'})
call Hl('changed',        { 'fg': 'none'})
call Hl('removed',        { 'fg': 'gray'})

" :help highlight-groups
call Hl('colorcolumn',       { 'fg': 'none'})
call Hl('conceal',           { 'fg': 'gray'})
call Hl('cursearch',         { 'bg': 'darkgray'})
call Hl('cursor',            { 'fg': 'none'})
call Hl('cursorcolumn',      { 'fg': 'none'})
call Hl('cursorim',          { 'fg': 'none'})
call Hl('cursorline',        { 'fg': 'none'})
call Hl('cursorlinefold',    { 'fg': 'none'})
call Hl('cursorlinenr',      { 'fg': 'none'})
call Hl('cursorlinesign',    { 'fg': 'none'})
call Hl('diffadd',           { 'fg': 'black', 'bg': 'gray'})
call Hl('diffchange',        { 'fg': 'none'})
call Hl('diffdelete',        { 'fg': 'gray'})
call Hl('difftext',          { 'fg': 'black', 'bg': 'gray'})
call Hl('directory',         { 'fg': 'none'})
call Hl('endofbuffer',       { 'fg': 'gray'})
call Hl('errormsg',          { 'fg': 'none'})
call Hl('foldcolumn',        { 'fg': 'none'})
call Hl('folded',            { 'fg': 'gray'})
call Hl('incsearch',         { 'fg': 'none', 'bg': 'darkgray'})
call Hl('lcursor',           { 'fg': 'none'})
call Hl('linenr',            { 'fg': 'gray'})
call Hl('linenrabove',       { 'fg': 'none'})
call Hl('linenrbelow',       { 'fg': 'none'})
call Hl('matchparen',        { 'fg': 'none', 'bg': 'darkgray'})
call Hl('messagewindow',     { 'fg': 'none'})
call Hl('modemsg',           { 'fg': 'none'})
call Hl('moremsg',           { 'fg': 'none'})
call Hl('msgarea',           { 'fg': 'none'})
call Hl('nontext',           { 'fg': 'gray'})
call Hl('pmenu',             { 'bg': 'black'})
call Hl('pmenuextra',        { 'bg': 'black'})
call Hl('pmenuextrasel',     { 'fg': 'none', 'bg': 'darkgray'})
call Hl('pmenukind',         { 'bg': 'black'})
call Hl('pmenukindsel',      { 'fg': 'none', 'bg': 'darkgray'})
call Hl('pmenumatch',        { 'bg': 'black'})
call Hl('pmenumatchsel',     { 'fg': 'none', 'bg': 'darkgray'})
call Hl('pmenusbar',         { 'bg': 'black'})
call Hl('pmenusel',          { 'fg': 'none', 'bg': 'darkgray'})
call Hl('pmenuthumb',        { 'bg': 'darkgray'})
call Hl('popupnotification', { 'bg': 'black'})
call Hl('question',          { 'fg': 'none'})
call Hl('quickfixline',      { 'fg': 'none'})
call Hl('search',            { 'fg': 'none', 'bg': 'darkgray'})
call Hl('signcolumn',        { 'fg': 'none'})
call Hl('specialkey',        { 'fg': 'gray'})
call Hl('spellbad',          { 'fg': 'black', 'bg': 'red'})
call Hl('spellcap',          { 'fg': 'black', 'bg': 'red'})
call Hl('spelllocal',        { 'fg': 'black', 'bg': 'red'})
call Hl('spellrare',         { 'fg': 'black', 'bg': 'red'})
call Hl('statusline',        { 'fg': 'gray', 'bg': 'black'})
call Hl('statuslinenc',      { 'fg': 'darkgray', 'bg': 'black'})
call Hl('statuslineterm',    { 'fg': 'gray', 'bg': 'black'})
call Hl('statuslinetermnc',  { 'fg': 'darkgray', 'bg': 'black'})
call Hl('tabline',           { 'fg': 'darkgray', 'bg': 'black'})
call Hl('tablinefill',       { 'fg': 'darkgray', 'bg': 'black'})
call Hl('tablinesel',        { 'fg': 'gray',  'bg': 'black'})
call Hl('terminal',          { 'fg': 'none'})
call Hl('title',             { 'fg': 'none'})
call Hl('vertsplit',         { 'bg': 'black'})
call Hl('visual',            { 'fg': 'none', 'bg': 'darkgray'})
call Hl('visualnos',         { 'fg': 'none', 'bg': 'darkgray'})
call Hl('warningmsg',        { 'fg': 'none'})
call Hl('wildmenu',          { 'bg': 'darkgray'})
