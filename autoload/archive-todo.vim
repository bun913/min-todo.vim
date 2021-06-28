function DoneTask()
  " Make a task Done
  let row = getline(".")
  let replaced = substitute(row, '\[ \]', "\[x\]", "g")
  call setline(".", replaced)
  " Append timestamp
  let nowPos = getpos(".")
  let now = "@". strftime("%Y-%m-%d %H:%M:%S")
  let col = col("$")
  call cursor(".", col)
  execute ":normal a" . now
  " Back to the org position
  call setpos(".", nowPos)
endfunction

function UndoTask()
  " Make a task Uncheck
  let row = getline(".")
  let replaced = substitute(row, '\[x\]', '\[ \]', 'g')
  call setline(".", replaced)
  " Delete timestamp
  let row = getline(".")
	let deleted = substitute(row, '@\d\{4\}-\d\{2\}-\d\{2\} \d\{2\}:\d\{2\}:\d\{2\}.*$', '', 'g')
  call setline(".", deleted)
endfunction

nnoremap <leader><cr> :call DoneTask()<cr>
nnoremap <leader>u :call UndoTask()<cr>
