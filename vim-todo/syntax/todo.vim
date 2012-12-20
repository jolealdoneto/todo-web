:syn match hash /#[a-zA-Z]\+/ 
:syn match duedate /\^[a-zA-Z0-9-/.]\+/ 
:syn match prj /@[a-zA-Z0-9-/.]\+/ 
:syn region prioa start=/(a)/ end="$" oneline contains=hash,duedate,prj
:syn region priob start=/(b)/ end="$" oneline contains=hash,duedate,prj
:syn region prioc start=/(c)/ end="$" oneline contains=hash,duedate,prj
:syn region priod start=/(d)/ end="$" oneline contains=hash,duedate,prj
:syn region prioe start=/(e)/ end="$" oneline contains=hash,duedate,prj


hi def prioa ctermfg=red
hi def priob ctermfg=blue
hi def prioc ctermfg=green
hi def priod ctermfg=magenta
hi def prioe ctermfg=grey

hi def hash ctermbg=green ctermfg=white
hi def duedate ctermbg=white ctermfg=red
hi def prj ctermbg=blue ctermfg=white
