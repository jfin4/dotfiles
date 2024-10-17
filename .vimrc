" first thing's first
colorscheme jfin

" define variables
let mapleader = ' '
let maplocalleader = ' '

" default options first, following can override

" dir options
set backupdir=~/.cache/vim/backup
set directory=~/.cache/vim/swap
set undodir=~/.cache/vim/undo 
set viewdir=~/.cache/vim/view
set shadafile=~/.cache/vim/shada

" other options
set autoread 
set autowriteall
set completeopt=menuone,longest
set encoding=utf-8
set ignorecase 
set laststatus=3
set mouse=
set pastetoggle=<insert> 
set signcolumn=no
set shellcmdflag='-c'
set shellslash
set shellquote=""
set shellxquote=""
set smartcase 
set undofile 
set virtualedit=block
set wildmenu
set formatoptions=qlcjnr

" maps
nnoremap <backspace> :bdelete<cr>
nnoremap <c-j> :bnext<cr>
nnoremap <c-k> :bprevious<cr>
nnoremap <cr> :write<cr>
nnoremap <leader>N viwy/<c-r>"<cr>NN
nnoremap <leader>n viwy/<c-r>"<cr>
nnoremap <leader>w :wincmd w<cr>
nnoremap <silent> <esc> :noh<cr>
xnoremap Y "*y

" commands
cnoreabbrev h help \| only \| set buflisted<home><s-right>

" indentation
set autoindent 
set breakindent 
set breakindentopt=min:0,shift:1
set expandtab 
set linebreak 
set shiftround 
set shiftwidth=4
set showbreak=+
set tabstop=4
set textwidth=78 

" folds
set foldlevelstart=0
set foldmethod=marker

" snippets
let g:snipMate = get(g:, 'snipMate', {
            \ 'always_choose_first' : 1,
            \ 'no_match_completion_feedkeys_chars' : '',
            \ })
inoremap <c-l> <Plug>snipMateNextOrTrigger
snoremap <c-l> <Plug>snipMateNextOrTrigger
inoremap <c-h <Plug>snipMateBack
snoremap <c-h> <Plug>snipMateBack
augroup snipmate
   au!
   autocmd bufleave *.snippets SnipMateLoadScope %
augroup end

" completion
let g:mucomplete#empty_text = 1
let g:mucomplete#no_mappings = 1
let g:mucomplete#chains = {
    \ 'default' : ['path', 'omni', 'keyp', 'dict', 'uspl'],
    \ }

imap <tab> <plug>(MUcompleteFwd)
imap <s-tab> <plug>(MUcompleteBwd)
imap <c-j> <plug>(MUcompleteCycFwd)
imap <c-k> <plug>(MUcompleteCycBwd)
imap <expr> . mucomplete#extend_bwd(".")

" get highlight group
function! GetHighlight()
    let hi    = synIDattr(synID(line('.'), col('.'), 1), 'name')
    let trans = synIDattr(synID(line('.'), col('.'), 0), 'name')
    let lo    = synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    echo 'hi:' . hi . ', trans:' . trans . ', lo:' . lo
endfunction
nnoremap <f10> :call GetHighlight()<cr>

" source updated config files 
augroup vimrc
    au!
    autocmd BufWritePost .vimrc,*/colors/*.vim,*/plugin/*.vim source <afile>
augroup end

" lsp
" Function to check if a specific LSP server is running
function! IsServerRunning(name)
    let clients = luaeval("vim.lsp.get_active_clients()")
    for client in clients
        if client.name == a:name
            return 1
        endif
    endfor
    return 0
endfunction

if !IsServerRunning('r_language_server')
    lua require'lspconfig'.r_language_server.setup{}
endif

lua vim.diagnostic.disable()

" clipboard
" set clipboard^=unnamedplus
let g:clipboard = {
    \   'name': 'clipboard',
    \   'copy': {
    \      '+': "sh -c 'cat > /dev/clipboard'",
    \      '*': "sh -c 'cat > /dev/clipboard'",
    \    },
    \   'paste': {
    \      '+': "sh -c 'cat /dev/clipboard'",
    \      '*': "sh -c 'cat /dev/clipboard'",
    \   },
    \ }

" fzf
let g:fzf_layout = { 'down': '40%' }
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fl :BLines<cr>
nnoremap <leader>fh :Helptags<cr>

" ai avante
lua require('avante_lib').load()
lua << EOF
    require('avante').setup ({ 
        -- provider = "openai",
        -- auto_suggestions_provider = "openai", 
        -- provider = "claude",
        -- auto_suggestions_provider = "claude", 
        provider = "deepseek",
        auto_suggestions_provider = "deepseek", 
        openai = {
            model = "gpt-4o-mini",
        },
        hints = { enabled = false },
        vendors = {
            ---@type AvanteProvider
            deepseek = {
                endpoint = "https://api.deepseek.com/chat/completions",
                model = "deepseek-coder",
                api_key_name = "DEEPSEEK_API_KEY",
                parse_curl_args = function(opts, code_opts)
                return {
                    url = opts.endpoint,
                    headers = {
                        ["Accept"] = "application/json",
                        ["Content-Type"] = "application/json",
                        ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
                    },
                    body = {
                        model = opts.model,
                        messages = { -- you can make your own message, but this is very advanced
                        { role = "system", content = code_opts.system_prompt },
                        { role = "user", content = require("avante.providers.openai").get_user_message(code_opts) },
                        },
                        temperature = 0,
                        max_tokens = 4096,
                        stream = true, -- this will be set by default.
                    },
                }
                end,
                parse_response_data = function(data_stream, event_state, opts)
                require("avante.providers").openai.parse_response(data_stream, event_state, opts)
                end,
            }
        }
    })
EOF

