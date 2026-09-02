set exrc
set secure
set statusline=
set statusline+=[%{FugitiveHead()}]
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=\ %y
set statusline+=\[%{&fileformat}\]
set statusline+=\ %l:%c
set nowrap
set autoread
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround
set relativenumber
set number
set clipboard+=unnamedplus
set list
set noswapfile
set undodir=~/.vim/undo-dir
set undofile
set ignorecase
set smartcase
set nopaste
set inccommand=nosplit
set diffopt+=iwhite
set splitright
colorscheme tokyonight-night
autocmd VimEnter * highlight Normal guibg=NONE ctermbg=NONE
autocmd VimEnter * highlight NormalNC guibg=NONE ctermbg=NONE
autocmd VimEnter * highlight NormalFloat guibg=NONE ctermbg=NONE
autocmd VimEnter * highlight SignColumn guibg=NONE ctermbg=NONE
autocmd VimEnter * highlight EndOfBuffer guibg=NONE ctermbg=NONE
" set backupcopy=yes
set sidescroll=40
set shell=/bin/zsh
set autoindent
set mouse=a
