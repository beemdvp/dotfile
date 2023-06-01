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
  let task_type = split(FugitiveHead(), '/')[0]
  if task_type =~ 'feat' || task_type =~ 'chore' || task_type =~ 'fix'
    let a = GetJiraIssue(task_type . "/")
    execute "Git commit -m \"" . a . " - " . a:1 . "\""
  else 
    execute "Git commit -m \"" . a:1 . "\""
  endif
endfunction

function! GetJiraIssue(task_type)
    return join([split(split(FugitiveHead(), a:task_type)[0], '-')[0], split(split(FugitiveHead(), a:task_type)[0], '-')[1]], '-')
endfunction
