if exists('g:loaded_mintodo')
  finish
endif
let g:loaded_mintodo = 1

command! DoneTask call mintodo#DoneTask()
command! UndoTask call mintodo#UndoTask()
command! ToggleTask call mintodo#ToggleTask()
command! CreateTask call mintodo#CreateTask()
command! ArchiveTasks call mintodo#ArchiveTasks()

