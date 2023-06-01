set nocompatible
call plug#begin('~/.vim/plugged')
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-fugitive'
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'KKPMW/oldbook-vim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  " Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
  Plug 'joukevandermaas/vim-ember-hbs', {'for': 'handlebars'}
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'mileszs/ack.vim'
  Plug 'racer-rust/vim-racer'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
  Plug 'aquach/vim-http-client'
  Plug 'joshdick/onedark.vim'
  Plug 'idanarye/vim-merginal'
  Plug 'cdata/vim-tagged-template'
  Plug 'sheerun/vim-polyglot'
  Plug 'samoshkin/vim-mergetool'
  Plug 'udalov/kotlin-vim'
  Plug 'neovim/nvim-lspconfig'

  " LSP Support
  Plug 'williamboman/mason.nvim', {'do': ':MasonUpdate'} " Optional
  Plug 'williamboman/mason-lspconfig.nvim'               " Optional

  " Autocompletion
  Plug 'hrsh7th/nvim-cmp'         " Required
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-nvim-lsp'     " Required
  Plug 'L3MON4D3/LuaSnip'         " Required

  Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}

  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
  Plug 'dart-lang/dart-vim-plugin'
  Plug 'reisub0/hot-reload.vim'
call plug#end()

lua <<EOF
local lsp = require('lsp-zero').preset({
float_border = 'rounded',
  call_servers = 'local',
  configure_diagnostics = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = false,
  manage_nvim_cmp = {
    set_sources = 'recommended',
    set_basic_mappings = true,
    set_extra_mappings = false,
    use_luasnip = true,
    set_format = true,
    documentation_window = true,
  },
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = bufnr})
  vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  vim.keymap.set('x', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end)

-- " (Optional) Configure lua language server for neovim
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}
lspconfig.angularls.setup{}

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = {
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
    ['<CR>'] = cmp.mapping.confirm({select = false}),
  }
})

lsp.format_on_save({
  servers = {
    ['rust_analyzer'] = {'rust'},
  }
})

lsp.setup()
EOF

runtime ./lsp.vim
runtime ./vim_settings.vim
runtime ./mappings.vim
runtime ./syntax_settings.vim
" runtime ./coc_config.vim
runtime ./git_helpers.vim

" allows selecting all from the fzf command line
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

function! g:FormatJson()
    execute '%!python -m json.tool'
    execute 'set ft=json'
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
" let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
" let g:netrw_localrmdir='rm -r'
let g:netrw_rmdir_cmd='rm -r'
let g:ackprg = 'ag --nogroup --nocolor --column --vimgrep'

let g:clipboard = {
            \ 'name': 'win32yank',
            \ 'copy': { 
            \ '+': 'win32yank.exe -i --crlf',
            \ '*': 'win32yank.exe -i --crlf',
            \  }, 
            \ 'paste': { 
            \ '+': 'win32yank.exe -o --lf',
            \ '*': 'win32yank.exe -o --lf',
            \  },
            \ 'cache_enabled': 1,
            \  }
