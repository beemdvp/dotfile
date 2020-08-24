call plug#begin('~/.vim/plugged')
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
call plug#end()

runtime ./vim_settings.vim
runtime ./mappings.vim
runtime ./syntax_settings.vim
runtime ./coc_config.vim
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
