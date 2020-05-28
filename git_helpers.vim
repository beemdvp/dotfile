" get edited files against master in current branch
function! CommitQF(...)
    " Get the commit hash if it was specified
    let commit = a:0 == 0 ? '' : a:1

    " Get the result of git show in a list
    let flist = system('git diff --name-status master')
    let flist = split(flist, '\n')

    " Create the dictionnaries used to populate the quickfix list
    let list = []
    for f in flist
        let file =  split(split(f, 'M')[0], 'A')[0]
        let movedFiles = split(split(file, 'R052')[0], '\t')[0]
        let strippedFile = substitute(file, '^\s*\(.\{-}\)\s*$', '\1', '')
        let dic = {'filename': movedFiles, "lnum": 1}
        call add(list, dic)
    endfor

    " Populate the qf list
    call setqflist(list)
endfunction

function! CommitMessage(...)
  if 'feature/' =~ FugitiveHead()
    let a = join([split(split(FugitiveHead(), 'feature/')[0], '-')[0], split(split(FugitiveHead(), 'feature/')[0], '-')[1]], '-')
    execute "Gcommit -m \"" . a . " - " . a:1 . "\""
  else 
    execute "Gcommit -m \"" . a:1 . "\""
  endif
endfunction


