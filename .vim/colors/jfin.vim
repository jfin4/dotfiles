" see /usr/share/vim/vim90/colors/README.txt

set background=dark
set termguicolors
let colors_name = "jfin"

" function to apply colors to a highlight group using a dictionary for named arguments
function! Hl(group, opts)
    " Set default values for foreground (fg), background (bg), and gui if not provided
    let fg = has_key(a:opts, 'fg') ? a:opts.fg : 'none'
    let bg = has_key(a:opts, 'bg') ? a:opts.bg : 'none'
    let style = has_key(a:opts, 'gui') ? a:opts.style : 'none'

    " Apply the highlight group using the dictionary arguments
    let cmd = printf('highlight %s guifg=%s guibg=%s gui=%s',
                \a:group,
                \fg,
                \bg,
                \style)

    execute cmd
endfunction

" define colors
let s:darkgray  = '#333333'
let s:blue      = '#99ccff'
let s:green     = '#99ff99'
let s:cyan      = '#99ffff'
let s:red       = '#ff9966'
let s:magenta   = '#ff99cc'
let s:yellow    = '#ffff99'
let s:lightgray = '#999999'
let s:none      = 'none'

call Hl('normal', {'fg': s:none})

" :help group-name

call Hl('comment',        {'fg': s:lightgray})

call Hl('constant',       {'fg': s:blue})
call Hl('string',         {'fg': s:blue})
call Hl('character',      {'fg': s:blue})
call Hl('number',         {'fg': s:blue})
call Hl('boolean',        {'fg': s:blue})
call Hl('float',          {'fg': s:blue})

call Hl('identifier',     {'fg': s:none})
call Hl('function',       {'fg': s:none})

call Hl('statement',      {'fg': s:none})
call Hl('conditional',    {'fg': s:none})
call Hl('repeat',         {'fg': s:none})
call Hl('label',          {'fg': s:none})
call Hl('operator',       {'fg': s:none})
call Hl('keyword',        {'fg': s:none})
call Hl('exception',      {'fg': s:none})

call Hl('preproc',        {'fg': s:none})
call Hl('include',        {'fg': s:none})
call Hl('define',         {'fg': s:none})
call Hl('macro',          {'fg': s:none})
call Hl('precondit',      {'fg': s:none})

call Hl('type',           {'fg': s:none})
call Hl('storageclass',   {'fg': s:none})
call Hl('structure',      {'fg': s:none})
call Hl('typedef',        {'fg': s:none})

call Hl('special',        {'fg': s:none})
call Hl('specialchar',    {'fg': s:none})
call Hl('tag',            {'fg': s:none})
call Hl('delimiter',      {'fg': s:none})
call Hl('specialcomment', {'fg': s:none})
call Hl('debug',          {'fg': s:none})

call Hl('underlined',     {'style': 'underline'})

call Hl('ignore',         {'fg': s:none})

call Hl('error',          {'fg': s:red})

call Hl('todo',           {'bg': s:darkgray})

call Hl('added',          {'bg': s:darkgray})
call Hl('changed',        {'fg': s:none})
call Hl('removed',        {'fg': s:lightgray})

" :help highlight-groups

call Hl('ColorColumn',    {'fg': s:none})
call Hl('Conceal',        {'fg': s:lightgray})
call Hl('CurSearch',      {'bg': s:lightgray})
call Hl('Cursor',         {'fg': s:none})
call Hl('lCursor',        {'fg': s:none})
call Hl('CursorIM',       {'fg': s:none})
call Hl('CursorColumn',   {'fg': s:none})
call Hl('CursorLine',     {'fg': s:none})
call Hl('Directory',      {'fg': s:none})
call Hl('DiffAdd',        {'bg': s:darkgray})
call Hl('DiffChange',     {'fg': s:none})
call Hl('DiffDelete',     {'fg': s:lightgray})
call Hl('DiffText',       {'bg': s:darkgray})
call Hl('EndOfBuffer',    {'fg': s:lightgray})
call Hl('TermCursor',     {'fg': s:none})
call Hl('TermCursorNC',   {'fg': s:none})
call Hl('ErrorMsg',       {'fg': s:red})
call Hl('WinSeparator',   {'fg': s:darkgray})
call Hl('Folded',         {'fg': s:lightgray})
call Hl('FoldColumn',     {'fg': s:none})
call Hl('SignColumn',     {'fg': s:none})
call Hl('IncSearch',      {'bg': s:darkgray})
call Hl('Substitute',     {'bg': s:darkgray})
call Hl('LineNr',         {'fg': s:lightgray})
call Hl('LineNrAbove',    {'fg': s:none})
call Hl('LineNrBelow',    {'fg': s:none})
call Hl('CursorLineNr',   {'fg': s:none})
call Hl('CursorLineFold', {'fg': s:none})
call Hl('CursorLineSign', {'fg': s:none})
call Hl('MatchParen',     {'bg': s:darkgray})
call Hl('ModeMsg',        {'fg': s:lightgray})
call Hl('MsgArea',        {'fg': s:none})
call Hl('MsgSeparator',   {'fg': s:none})
call Hl('MoreMsg',        {'fg': s:none})
call Hl('NonText',        {'fg': s:lightgray})
call Hl('NormalFloat',    {'fg': s:none})
call Hl('FloatBorder',    {'fg': s:darkgray})
call Hl('FloatTitle',     {'fg': s:none})
call Hl('FloatFooter',    {'fg': s:none})
call Hl('NormalNC',       {'fg': s:none})
call Hl('Pmenu',          {'bg': s:darkgray})
call Hl('PmenuSel',       {'bg': s:lightgray})
call Hl('PmenuKind',      {'bg': s:darkgray})
call Hl('PmenuKindSel',   {'bg': s:lightgray})
call Hl('PmenuExtra',     {'bg': s:darkgray})
call Hl('PmenuExtraSel',  {'bg': s:lightgray})
call Hl('PmenuSbar',      {'bg': s:darkgray})
call Hl('PmenuThumb',     {'bg': s:lightgray})
call Hl('Question',       {'fg': s:none})
call Hl('QuickFixLine',   {'fg': s:none})
call Hl('Search',         {'bg': s:darkgray})
call Hl('SnippetTabstop', {'bg': s:darkgray})
call Hl('SpecialKey',     {'fg': s:lightgray})
call Hl('SpellBad',       {'fg': s:red})
call Hl('SpellCap',       {'fg': s:red})
call Hl('SpellLocal',     {'fg': s:red})
call Hl('SpellRare',      {'fg': s:red})
call Hl('StatusLine',     {'fg': s:lightgray})
call Hl('StatusLineNC',   {'fg': s:lightgray})
call Hl('TabLine',        {'fg': s:lightgray})
call Hl('TabLineFill',    {'fg': s:lightgray})
call Hl('TabLineSel',     {'fg': s:lightgray})
call Hl('Title',          {'fg': s:none})
call Hl('Visual',         {'bg': s:darkgray})
call Hl('VisualNOS',      {'bg': s:darkgray})
call Hl('WarningMsg',     {'fg': s:red})
call Hl('Whitespace',     {'fg': s:lightgray})
call Hl('WildMenu',       {'bg': s:darkgray})
call Hl('WinBar',         {'fg': s:none})
call Hl('WinBarNC',       {'fg': s:none})
