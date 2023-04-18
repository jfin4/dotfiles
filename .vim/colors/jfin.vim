" see /usr/share/vim/vim90/colors/README.txt

set background=dark
highlight clear 
let colors_name = "jfin"
" set t_Co=16
highlight Normal ctermfg=white ctermbg=black cterm=NONE guifg=#ffffff guibg=#000000 gui=NONE

" :help v:colornames

let v:colornames['alt_black']       = '#000000'
let v:colornames['alt_darkgray']    = '#696969'
let v:colornames['alt_darkblue']    = '#87cefa'
let v:colornames['alt_blue']        = '#87cefa'
let v:colornames['alt_darkgreen']   = '#98bf98'
let v:colornames['alt_green']       = '#98bf98'
let v:colornames['alt_darkcyan']    = '#afeeee'
let v:colornames['alt_cyan']        = '#afeeee'
let v:colornames['alt_darkred']     = '#fa8072'
let v:colornames['alt_red']         = '#fa8072'
let v:colornames['alt_darkmagenta'] = '#ddaodd'
let v:colornames['alt_magenta']     = '#ddaodd'
let v:colornames['alt_brown']       = '#eee8aa'
let v:colornames['alt_yellow']      = '#eee8aa'
let v:colornames['alt_lightgray']   = '#a9a9a9'
let v:colornames['alt_white']       = '#ffffff' 

" :help cterm-colors
" :help group-name

highlight Comment    ctermfg=lightgray ctermbg=NONE     cterm=NONE      guifg=alt_lightgray guibg=NONE         gui=NONE      
highlight Constant   ctermfg=yellow    ctermbg=NONE     cterm=NONE      guifg=alt_yellow    guibg=NONE         gui=NONE      
highlight Identifier ctermfg=white     ctermbg=NONE     cterm=NONE      guifg=NONE          guibg=NONE         gui=NONE      
highlight Statement  ctermfg=white     ctermbg=NONE     cterm=NONE      guifg=NONE          guibg=NONE         gui=NONE      
highlight PreProc    ctermfg=white     ctermbg=NONE     cterm=NONE      guifg=NONE          guibg=NONE         gui=NONE      
highlight Type       ctermfg=white     ctermbg=NONE     cterm=NONE      guifg=NONE          guibg=NONE         gui=NONE      
highlight Special    ctermfg=white     ctermbg=NONE     cterm=NONE      guifg=NONE          guibg=NONE         gui=NONE      
highlight Underlined ctermfg=white     ctermbg=NONE     cterm=underline guifg=NONE          guibg=NONE         gui=underline 
highlight Ignore     ctermfg=lightgray ctermbg=NONE     cterm=NONE      guifg=alt_lightgray guibg=NONE         gui=NONE      
highlight Error      ctermfg=red       ctermbg=NONE     cterm=NONE      guifg=alt_red       guibg=NONE         gui=NONE      
highlight Todo       ctermfg=white     ctermbg=darkgray cterm=NONE      guifg=NONE          guibg=alt_darkgray gui=NONE      
 
" :help highlight-groups 

highlight ColorColumn       ctermfg=NONE      ctermbg=darkgray  cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE  
highlight Conceal           ctermfg=lightgray ctermbg=NONE      cterm=NONE guifg=alt_lightgray guibg=NONE          gui=NONE
highlight Cursor            ctermfg=NONE      ctermbg=white     cterm=NONE guifg=alt_black     guibg=alt_white     gui=NONE
highlight lCursor           ctermfg=NONE      ctermbg=NONE      cterm=NONE guifg=NONE          guibg=NONE          gui=NONE
highlight CursorIM          ctermfg=NONE      ctermbg=NONE      cterm=NONE guifg=NONE          guibg=NONE          gui=NONE
highlight CursorColumn      ctermfg=NONE      ctermbg=darkgray  cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE
highlight CursorLine        ctermfg=NONE      ctermbg=darkgray  cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE
highlight Directory         ctermfg=NONE      ctermbg=NONE      cterm=NONE guifg=NONE          guibg=NONE          gui=NONE
highlight DiffAdd           ctermfg=green     ctermbg=darkgray  cterm=NONE guifg=alt_green     guibg=alt_darkgray  gui=NONE
highlight DiffChange        ctermfg=NONE      ctermbg=darkgray  cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE
highlight DiffDelete        ctermfg=red       ctermbg=darkgray  cterm=NONE guifg=alt_red       guibg=alt_darkgray  gui=NONE
highlight DiffText          ctermfg=green     ctermbg=darkgray  cterm=NONE guifg=alt_green     guibg=alt_darkgray  gui=NONE
highlight EndOfBuffer       ctermfg=lightgray ctermbg=NONE      cterm=NONE guifg=alt_lightgray guibg=NONE          gui=NONE
highlight ErrorMsg          ctermfg=red       ctermbg=NONE      cterm=NONE guifg=alt_red       guibg=NONE          gui=NONE
highlight VertSplit         ctermfg=NONE      ctermbg=darkgray  cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE
highlight Folded            ctermfg=lightgray ctermbg=darkgray  cterm=NONE guifg=alt_lightgray guibg=alt_darkgray  gui=NONE
highlight FoldColumn        ctermfg=lightgray ctermbg=darkgray  cterm=NONE guifg=alt_lightgray guibg=alt_darkgray  gui=NONE
highlight SignColumn        ctermfg=lightgray ctermbg=darkgray  cterm=NONE guifg=alt_lightgray guibg=alt_darkgray  gui=NONE
highlight IncSearch         ctermfg=NONE      ctermbg=darkgray  cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE
highlight LineNr            ctermfg=lightgray ctermbg=darkgray  cterm=NONE guifg=alt_lightgray guibg=alt_darkgray  gui=NONE
highlight LineNrAbove       ctermfg=lightgray ctermbg=darkgray  cterm=NONE guifg=alt_lightgray guibg=alt_darkgray  gui=NONE
highlight LineNrBelow       ctermfg=lightgray ctermbg=darkgray  cterm=NONE guifg=alt_lightgray guibg=alt_darkgray  gui=NONE
highlight CursorLineNr      ctermfg=lightgray ctermbg=darkgray  cterm=NONE guifg=alt_lightgray guibg=alt_darkgray  gui=NONE
highlight CursorLineFold    ctermfg=lightgray ctermbg=darkgray  cterm=NONE guifg=alt_lightgray guibg=alt_darkgray  gui=NONE
highlight CursorLineSign    ctermfg=lightgray ctermbg=darkgray  cterm=NONE guifg=alt_lightgray guibg=alt_darkgray  gui=NONE
highlight MatchParen        ctermfg=NONE      ctermbg=darkgray  cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE
highlight MessageWindow     ctermfg=NONE      ctermbg=darkgray  cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE
highlight ModeMsg           ctermfg=NONE      ctermbg=NONE      cterm=NONE guifg=NONE          guibg=NONE          gui=NONE
highlight MoreMsg           ctermfg=NONE      ctermbg=NONE      cterm=NONE guifg=NONE          guibg=NONE          gui=NONE
highlight NonText           ctermfg=lightgray ctermbg=NONE      cterm=NONE guifg=alt_lightgray guibg=NONE          gui=NONE
highlight Pmenu             ctermfg=NONE      ctermbg=darkgray  cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE
highlight PmenuSel          ctermfg=black     ctermbg=lightgray cterm=NONE guifg=alt_black     guibg=alt_lightgray gui=NONE
highlight PmenuKind         ctermfg=NONE      ctermbg=darkgray  cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE
highlight PmenuKindSel      ctermfg=black     ctermbg=lightgray cterm=NONE guifg=alt_black     guibg=alt_lightgray gui=NONE
highlight PmenuExtra        ctermfg=NONE      ctermbg=darkgray  cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE
highlight PmenuExtraSel     ctermfg=black     ctermbg=lightgray cterm=NONE guifg=alt_black     guibg=alt_lightgray gui=NONE
highlight PmenuSbar         ctermfg=NONE      ctermbg=lightgray cterm=NONE guifg=NONE          guibg=alt_lightgray gui=NONE
highlight PmenuThumb        ctermfg=NONE      ctermbg=darkgray  cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE
highlight PopupNotification ctermfg=NONE      ctermbg=darkgray  cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE
highlight Question          ctermfg=NONE      ctermbg=NONE      cterm=NONE guifg=NONE          guibg=NONE          gui=NONE
highlight QuickFixLine      ctermfg=NONE      ctermbg=darkgray  cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE
highlight Search            ctermfg=NONE      ctermbg=darkgray  cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE
highlight CurSearch         ctermfg=NONE      ctermbg=NONE      cterm=NONE guifg=NONE          guibg=NONE          gui=NONE
highlight SpecialKey        ctermfg=lightgray ctermbg=NONE      cterm=NONE guifg=alt_lightgray guibg=NONE          gui=NONE
highlight SpellBad          ctermfg=red       ctermbg=NONE      cterm=NONE guifg=alt_red       guibg=NONE          gui=NONE
highlight SpellCap          ctermfg=NONE      ctermbg=NONE      cterm=NONE guifg=NONE          guibg=NONE          gui=NONE
highlight SpellLocal        ctermfg=red       ctermbg=NONE      cterm=NONE guifg=alt_red       guibg=NONE          gui=NONE
highlight SpellRare         ctermfg=red       ctermbg=NONE      cterm=NONE guifg=alt_red       guibg=NONE          gui=NONE
highlight StatusLine        ctermfg=NONE      ctermbg=darkgray  cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE
highlight StatusLineNC      ctermfg=lightgray ctermbg=darkgray  cterm=NONE guifg=alt_lightgray guibg=alt_darkgray  gui=NONE
highlight StatusLineTerm    ctermfg=NONE      ctermbg=darkgray  cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE
highlight StatusLineTermNC  ctermfg=lightgray ctermbg=darkgray  cterm=NONE guifg=alt_lightgray guibg=alt_darkgray  gui=NONE
highlight TabLine           ctermfg=lightgray ctermbg=NONE      cterm=NONE guifg=alt_lightgray guibg=NONE          gui=NONE
highlight TabLineFill       ctermfg=NONE      ctermbg=NONE      cterm=NONE guifg=NONE          guibg=NONE          gui=NONE
highlight TabLineSel        ctermfg=NONE      ctermbg=NONE      cterm=NONE guifg=NONE          guibg=NONE          gui=NONE
highlight Terminal          ctermfg=NONE      ctermbg=NONE      cterm=NONE guifg=NONE          guibg=NONE          gui=NONE
highlight Title             ctermfg=NONE      ctermbg=NONE      cterm=NONE guifg=NONE          guibg=NONE          gui=NONE
highlight Visual            ctermfg=NONE      ctermbg=darkgray  cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE
highlight VisualNOS         ctermfg=NONE      ctermbg=darkgray  cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE
highlight WarningMsg        ctermfg=red       ctermbg=NONE      cterm=NONE guifg=alt_red       guibg=NONE          gui=NONE
highlight WildMenu          ctermfg=black     ctermbg=lightgray cterm=NONE guifg=NONE          guibg=alt_darkgray  gui=NONE
