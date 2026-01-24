set nocompatible
call plug#begin('~/.vim/plugged')
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-fugitive'
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'KKPMW/oldbook-vim'
  Plug 'tpope/vim-unimpaired'
  " Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
  Plug 'joukevandermaas/vim-ember-hbs', {'for': 'handlebars'}
  Plug 'LunarWatcher/auto-pairs'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'mileszs/ack.vim'
  Plug 'racer-rust/vim-racer'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
  Plug 'aquach/vim-http-client'
  Plug 'navarasu/onedark.nvim'
  Plug 'idanarye/vim-merginal'
  Plug 'cdata/vim-tagged-template'
  Plug 'sheerun/vim-polyglot'
  Plug 'samoshkin/vim-mergetool'
  Plug 'udalov/kotlin-vim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'tpope/vim-rails'
  Plug 'sbdchd/neoformat'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'MunifTanjim/nui.nvim'
  Plug 'MeanderingProgrammer/render-markdown.nvim'
  " LSP Support
  Plug 'williamboman/mason.nvim', {'do': ':MasonUpdate'} " Optional
  Plug 'williamboman/mason-lspconfig.nvim'               " Optional
  Plug 'ron-rs/ron.vim'
  " Autocompletion
  Plug 'hrsh7th/nvim-cmp'         " Required
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-nvim-lsp'     " Required
  Plug 'L3MON4D3/LuaSnip'         " Required
  Plug 'tiagovla/tokyodark.nvim'
  Plug 'folke/tokyonight.nvim'

  Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}

  Plug 'codota/tabnine-nvim', { 'do': './dl_binaries.sh' }
  Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }

  Plug 'tyru/open-browser.vim'
  Plug 'weirongxu/plantuml-previewer.vim'
"   Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
  " Plug 'dart-lang/dart-vim-plugin'
  " Plug 'reisub0/hot-reload.vim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'vim-test/vim-test'
  Plug 'akinsho/flutter-tools.nvim'
  Plug 'evanleck/vim-svelte'
  Plug 'Shougo/context_filetype.vim'
  Plug 'yanganto/move.vim', {'branch':'sui-move'}
  " Plug 'olimorris/codecompanion.nvim'
  Plug 'nvim-tree/nvim-web-devicons' "or Plug 'echasnovski/mini.icons'
  Plug 'HakonHarnes/img-clip.nvim'
  Plug 'stevearc/dressing.nvim' " for enhanced input UI
  Plug 'folke/snacks.nvim' " for modern input UI

  " Yay, pass source=true if you want to build from source
  Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }
  Plug 'milanglacier/minuet-ai.nvim'
  " Plug 'saghen/blink.cmp'
  " Plug 'github/copilot.vim'
call plug#end()


let g:neoformat_try_node_exe = 1
runtime ./lsp.vim
runtime ./vim_settings.vim
runtime ./mappings.vim
runtime ./syntax_settings.vim
runtime ./coc_config.vim
runtime ./git_helpers.vim

autocmd BufWritePre *.js Neoformat
autocmd BufWritePre *.ts Neoformat
autocmd BufWritePre *.tsx Neoformat
autocmd BufWritePre *.svelte Neoformat

let g:vim_svelte_plugin_load_full_syntax = 1

" autocmd! User avante.nvim

lua <<EOF
vim.o.background = "dark"
-- require('tabnine').setup({
--   disable_auto_comment=true,
--   accept_keymap="<C-e>",
--   dismiss_keymap = "<C-]>",
--   debounce_ms = 800,
--   suggestion_color = {gui = "#808080", cterm = 244},
--   exclude_filetypes = {"TelescopePrompt", "NvimTree"},
--   log_file_path = nil, -- absolute path to Tabnine log file
-- })

require('img-clip').setup()

require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true
  }
})

require('render-markdown').setup({
  file_types = { "markdown", "Avante", "AvanteInput" },
  code = {
    enabled = true
  }
})

local chat_llm_model = "ministral-3:14b"

require('avante').setup({
  provider = "ollama",
  mode = "legacy",
  -- auto_suggestions_provider = "ollama",
  input = {
    provider = "dressing"
  },
  providers = {
    ollama = {
      model = chat_llm_model,
      is_env_set = function()
        return true
      end,
      disable_tools = true,
      use_ReAct_prompt = true,
      extra_request_body = {
        keep_alive = "24h",
        num_ctx = 256000
      }
    }
  },
  behaviour = {
    auto_approve_tool_permissions = false, -- Default: auto-approve all tools (no prompts)
  },
  -- rag_service = { -- RAG service configuration
  --   enabled = true,
  --   host_mount = "/home/beem", -- Host mount path for the RAG service (Docker will mount this path)
  --   runner = "docker", -- The runner for the RAG service (can use docker or nix)
  --   llm = { -- Configuration for the Language Model (LLM) used by the RAG service
  --     provider = "ollama", -- The LLM provider ("ollama")
  --     endpoint = "http://localhost:11434", -- The LLM API endpoint for Ollama
  --     api_key = "", -- Ollama typically does not require an API key
  --     model = chat_llm_model, -- The LLM model name (e.g., "llama2", "mistral")
  --     extra = nil, -- Extra configuration options for the LLM (optional) Kristin", -- Extra configuration options for the LLM (optional)
  --   },
  --   embed = { -- Configuration for the Embedding Model used by the RAG service
  --     provider = "ollama", -- The Embedding provider ("ollama")
  --     endpoint = "http://localhost:11434", -- The Embedding API endpoint for Ollama
  --     api_key = "", -- Ollama typically does not require an API key
  --     model = "nomic-embed-text", -- The Embedding model name (e.g., "nomic-embed-text")
  --     -- extra = { -- Extra configuration options for the Embedding model (optional)
  --     --   embed_batch_size = 10,
  --     -- },
  --   },
  -- },
})

-- local rag_service = require('avante.rag_service')

-- rag_service.launch_rag_service(function()
--  local result = rag_service.add_resource("file:///home/beem/Projects/frax-rupture-frontend/")
--  print(vim.inspect(result))
-- 
--   -- local status = rag_service.indexing_status("file:///Projects/frax-rupture-frontend/")
--   -- print(vim.inspect(status))  -- View indexing progress
-- end)

local code_completion_llm_model = 'qwen2.5-coder:7b'

-- require('minuet').setup {
--     provider = 'openai_fim_compatible',
--     n_completions = 1, -- recommend for local model for resource saving
--     -- I recommend beginning with a small context window size and incrementally
--     -- expanding it, depending on your local computing power. A context window
--     -- of 512, serves as an good starting point to estimate your computing
--     -- power. Once you have a reliable estimate of your local computing power,
--     -- you should adjust the context window to a larger value.
--     context_window = 512,
--     request_timeout = 60,
--     provider_options = {
--         openai_fim_compatible = {
--             -- For Windows users, TERM may not be present in environment variables.
--             -- Consider using APPDATA instead.
--             api_key = 'TERM',
--             name = 'Ollama',
--             end_point = 'http://localhost:11434/v1/completions',
--             model = code_completion_llm_model,
--             optional = {
--                 max_tokens = 100,
--                 max_context_length = 4096,
--                 top_p = 0.9,
--                 temperature = 0.7
--             },
--         },
--     },
--     virtualtext = {
--         auto_trigger_ft = { '*' },
--         show_on_completion_menu = true,
--         keymap = {
--             -- accept whole completion
--             accept = '<C-A>',
--             -- accept one line
--             accept_line = '<A-a>',
--             -- accept n lines (prompts for number)
--             -- e.g. "A-z 2 CR" will accept 2 lines
--             accept_n_lines = '<A-z>',
--             -- Cycle to prev completion item, or manually invoke completion
--             prev = '<A-[>',
--             -- Cycle to next completion item, or manually invoke completion
--             next = '<C-]>',
--             dismiss = '<A-e>',
--         },
--     },
-- }

-- require('llm').setup({
--   backend = "ollama",
--   model = "qwen2.5-coder:14b-instruct",
--   url = "http://localhost:11434",
--   context_window = 4096,
--   fim = {
--     enabled = true,
--     prefix = "<|fim_prefix|>",
--     middle = "<|fim_middle|>",
--     suffix = "<|fim_suffix|>",
--   },
--   tokenizer = {
--     repository = "Qwen/Qwen3-Coder-30B-A3B-Instruct"
--   },
--   request_body = {
--       -- Modelfile options for the model you use
--       temperature = 0.2,
--       top_p = 0.95,
--   }
-- })


require("mason").setup()
require("mason-lspconfig").setup()

-- local tabnine = require('cmp_tabnine.config')
-- 
-- tabnine:setup({
--   max_lines = 1000,
--   max_num_results = 20,
--   sort = true,
--   run_on_every_keystroke = true,
--   snippet_placeholder = '..',
--   ignored_file_types = {
--     -- default is not to ignore
--     -- uncomment to ignore in lua:
--     -- lua = true
--   },
--   show_prediction_strength = false
-- })

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
  vim.keymap.set('n', '<leader>s', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
end)

-- " (Optional) Configure lua language server for neovim
local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
-- lspconfig.pyright.setup {
--   capabilities = capabilities
-- }
-- lspconfig.solargraph.setup{
--   capabilities = capabilities
-- }
-- lspconfig.standardrb.setup{
--   capabilities = capabilities
-- }
if not configs.move_analyzer then
  configs.move_analyzer = {
    default_config = {
      cmd = { os.getenv("HOME") .. "/.cargo/bin/aptos-language-server", "lsp-server" },
      filetypes = { 'move' },
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = function(fname)
        return lspconfig.util.root_pattern("Move.toml", ".git")(fname)
      end,
      settings = {},
    },
  }
end

-- lspconfig.move_analyzer.setup{
--   capabilities = capabilities,
-- }

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = {
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
    ['<CR>'] = cmp.mapping.confirm({select = true}),
  },
  snippet = {
    expand = function(args)
    require('luasnip').lsp_expand(args.body)
    end,
  },
})

lsp.format_on_save({
  servers = {
    ['rust_analyzer'] = {'rust'},
    ['dartls'] = {'dart'}
  }
})

  function OpenDiagnosticIfNoFloat()
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(winid).zindex then
        return
      end
    end
    -- THIS IS FOR BUILTIN LSP
    vim.diagnostic.open_float(0, {
      scope = "cursor",
      focusable = false,
      close_events = {
        "CursorMoved",
        "CursorMovedI",
        "BufHidden",
        "InsertCharPre",
        "WinLeave",
      },
    })
  end
  -- Show diagnostics under the cursor when holding position
  vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    command = "lua OpenDiagnosticIfNoFloat()",
    group = "lsp_diagnostics_hold",
  })

lsp.setup()
EOF

" allows selecting all from the fzf command line
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" function! g:FormatJson()
"     execute '%!python -m json.tool'
"     execute 'set ft=json'
" endfunction

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

let g:test#rust#cargotest#test_options = {
  \ 'nearest': ['--nocapture'],
  \ 'file':    '',
\}

if !exists('g:context_filetype#same_filetypes')
  let g:context_filetype#filetypes = {}
endif

let g:svelte_preprocessor_tags = [
  \ { 'name': 'ts', 'tag': 'script', 'as': 'typescript' }
  \ ]
let g:svelte_preprocessors = ['ts']

let g:AutoPairsMapCR = 0
let g:copilot_proxy = 'http://localhost:11435'
let g:copilot_proxy_strict_ssl = v:false
