let mapleader = ","
nnoremap j gj
nnoremap k gk
noremap <Leader>of :GFiles<cr>
noremap <Leader>fif :Ack -Q ''<left>
noremap <Leader>y "+y
noremap <Leader>p "+p
" typescript definition
noremap <Leader>td :TSDef<cr>
" coc restart
" noremap <Leader>cr :CocRestart<cr><cr>
" find without test
noremap <Leader>fwt :Ack --ignore-dir="*Test.js" --ignore-dir="*Test.ts" --ignore-dir="*.feature" --ignore-dir="test/*" --ignore-dir="*-test.js" --ignore-dir="*tmp/*" --ignore-dir="*dist/*" -Q ''<left>
" clear search
map <leader><space> :let @/=''<cr> 
" git compare
noremap <Leader>gc :Gvdiffsplit HEAD~1<cr>
noremap <Leader>gC :Gvdiffsplit HEAD<cr>
" git commit message
noremap <Leader>gm :call CommitMessage("")<left><left>
" git ammend commit
noremap <Leader>gam :Git commit --am<cr> :q<cr><cr>
" join([split(split(FugitiveHead(), 'feature/')[0], '-')[0], split(split(FugitiveHead(), 'feature/')[0], '-')[1]], '-')
" git status
noremap <Leader>gs :Git<cr>
" git push
noremap <Leader>gp :Git push -u origin HEAD -f<cr>
" git pull
noremap <Leader>gu :Git pull<cr>
" git add tracked file
noremap <Leader>ga :Git add -u<cr>
" git add all
noremap <Leader>gA :Git add .<cr>
" git list branches
noremap <Leader>gl :Merginal<cr>
" js doc
noremap <Leader>jd :JsDoc<cr>
" search word
noremap <Leader>sw yiw:Ack "<c-r>""<cr>
" search end of word
noremap <Leader>s$ yW:FZF<cr>
noremap q: :History:<cr>
noremap q/ :History/<cr>
noremap <Leader>gC 02f/wy$:Git checkout <c-r>"<cr>
noremap <Leader>nt :tab new<cr>:terminal<cr>A
noremap <Leader>gpn 4Gwy$:!<c-r>"<cr>
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
tnoremap <Esc> <C-\><C-n>
tnoremap <Leader>tc :call ClearTerminal()<cr>
nnoremap <Leader>gd :call CommitQF()<cr> :copen<cr>
nnoremap / /\V
" nmap <silent> ga <Plug>(coc-codeaction)
" xmap <silent> ga <Plug>(coc-codeaction)
nnoremap <Leader>tw :set nowrap!<cr>
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <Leader>w :w<cr>
nmap <leader>mt <plug>(MergetoolToggle)
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
" xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
" nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
" nmap <leader>cl  <Plug>(coc-codelens-action)
" Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)
" nmap <leader>rn <Plug>(coc-rename)
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction

function! ClearTerminal()
  set scrollback=1
  let &g:scrollback=1
  echo &scrollback
  call feedkeys("\i")
  call feedkeys("clear\<CR>")
  call feedkeys("\<C-\>\<C-n>")
  call feedkeys("\i")
  sleep 100m
  let &scrollback=s:scroll_value
endfunction
