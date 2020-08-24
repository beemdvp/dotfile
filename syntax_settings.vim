function! EnableInlineHtmlSyntaxHighlightingForTypescript()
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    unlet b:current_syntax
  endif
  syn include @HTMLSyntax syntax/html.vim
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  endif

  syn region typescriptTemplateString contains=@HTMLSyntax,typescriptTemplateSubstitution
    \ containedin=typescriptTemplate,javascriptTemplate
    \ start=+\%(<\|\w\)\@<!<\z([a-zA-Z][a-zA-Z0-9:\-]*\)+
    \ skip=+<!--\_.\{-}-->+
    \ end=+</\z1\_\s\{-}>+
    \ end=+/>+
    \ keepend
    \ extend
endfunction

function! EnableCSS()
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    unlet b:current_syntax
  endif
  syn include @CssSyntax syntax/scss.vim
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  endif

  syn region typescriptTemplateString contains=@CssSyntax,typescriptTemplateSubstitution
    \ containedin=typescriptTemplate,javascriptTemplate
    \ start=+\.\|\#\|app\-.\+\|&\{1}.\+{+
    \ end=+}+
    \ keepend
    \ extend
endfunction

augroup ConfigGroup
  autocmd!
  autocmd FileType javascript setlocal suffixesadd+=.js,.ts
  autocmd FileType typescript setlocal suffixesadd+=.js,.ts
  autocmd FileType typescript let g:jsdoc_enable_es6 = 1
  autocmd BufRead,BufNewFile *.ts setfiletype typescript.html.scss
  autocmd FileType typescript noremap <Leader>tsi :TSImport<cr>
  autocmd FileType javascript noremap <Leader>tsi :TSImport<cr>
  " autocmd FileType typescript call EnableInlineHtmlSyntaxHighlightingForTypescript()
  " autocmd FileType typescript call EnableCSS()
augroup END

