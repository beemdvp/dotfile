" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()


" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" let g:coc_global_extensions = [
"       \ 'coc-angular',
"       \ 'coc-rust-analyzer',
"       \ 'coc-html',
"       \ 'coc-css',
"       \ 'coc-tsserver',
"       \ 'coc-snippets'
"       \ ]

" let g:coc_snippet_next = '<tab>'

