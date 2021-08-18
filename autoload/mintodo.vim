function! mintodo#IsDone(str)
  " Judge a task is done status
  let isInclude = match(a:str, '\[x\]')
  let result = 1
  if isInclude == -1
    unlet result
    let result = 0
  endif
  return result
endfunction

function! mintodo#ToggleTask()
  " Toogle a task status
  let row = getline('.')
  if mintodo#IsDone(row) == 1
    call mintodo#UndoTask()
  else
    call mintodo#DoneTask()
  endif
endfunction

function! mintodo#DoneTask()
  " Make a task done status
  let row = getline('.')
  let replaced = substitute(row, '\[ \]', '\[x\]', 'g')
  call setline('.', replaced)
  " Append timestamp
  let nowPos = getpos('.')
  let now = '@'. strftime('%Y-%m-%d %H:%M:%S')
  let col = col('$')
  call cursor('.', col)
  execute ':normal a' . now
  " Back to the org position
  call setpos('.', nowPos)
endfunction

function! mintodo#UndoTask()
  " Make a task uncheck status
  let row = getline('.')
  let replaced = substitute(row, '\[x\]', '\[ \]', 'g')
  call setline('.', replaced)
  " Delete timestamp
  let row = getline('.')
  let deleted = substitute(row, '@\d\{4\}-\d\{2\}-\d\{2\} \d\{2\}:\d\{2\}:\d\{2\}.*$', '', 'g')
  call setline('.', deleted)
endfunction

function! mintodo#CreateTask()
  " Create a task
  let nowPos = getpos('.')
  let taskPrefix = "- [ ] "
  let col = col('$')
  call cursor('.', col)
  execute ':normal a' . taskPrefix
endfunction

function! mintodo#ArchiveTasks()
  " Archive Done Tasks
  let last = line("$")
  let delList = []
  let i = 1
  while i < last
    let row = getline(i)
    let isTarget = mintodo#IsDone(row)
    " copy if task is done
    if isTarget == 1
        call append(line("$"), row)
        let delList = insert(delList, i, 0)
    endif
    let i = i + 1
    let nowLast = line("$")
  endwhile
  " delete lines
  for n in delList
    execute n . "delete" |
  endfor
endfunction

