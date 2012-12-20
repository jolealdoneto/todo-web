function! TodoModus()
    silent "!touch todo.todo"
    silent "!touch done.todo"
    open todo.todo
    :% ! sort
endfunction
function! TodoModusDo()
    let b=line('.')
    exe b." !sort >> done.todo"
endfunction

map <F8> :call TodoModus()<CR>
map <F9> :call TodoModusDo()<CR>
