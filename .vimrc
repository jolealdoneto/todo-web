syntax on
filetype plugin indent on

set number
" Annotate  for svn
vmap gf :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
 set tabstop=4
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p
 map <F2> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
 " With a map leader it's possible to do extra key combinations
" " like <leader>w saves the current file
 let mapleader = ","
 let g:mapleader = ","
 "
 " " Fast saving
 nmap <leader>w :w!<cr>
 " Height of the command bar
 set cmdheight=2
 "
 " " A buffer becomes hidden when it is abandoned
 set hid
 "
 " " Configure backspace so it acts as it should act
 set backspace=eol,start,indent
 set whichwrap+=<,>,h,l
 " Ignore case when searching
 set ignorecase
 "
 " " When searching try to be smart about cases 
 set smartcase
 "
 " " Highlight search results
 set hlsearch
" Makes search act like search in modern browsers
 set incsearch
 "
 " " Don't redraw while executing macros (good performance config)
 set lazyredraw
 "
 " " For regular expressions turn magic on
 set magic
 "
 " " Show matching brackets when text indicator is over them
 set showmatch
 " " How many tenths of a second to blink when matching brackets
 set mat=2


 colorscheme desert
 set background=dark
 " Set utf8 as standard encoding and en_US as the standard language
 set encoding=utf8
 set ai "Auto indent
 set si "Smart indent
 set wrap "Wrap lines
 " make "tab" insert indents instead of tabs at the beginning of a line
  set smarttab
  set shiftwidth=4
  set softtabstop=4
 "
 " " always uses spaces instead of tab characters
  set expandtab


 " Visual mode pressing * or # searches for the current selection
 " " Super useful! From an idea by Michael Naumann
 vnoremap <silent> * :call VisualSelection('f')<CR>
 vnoremap <silent> # :call VisualSelection('b')<CR>
 

 " Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
 map <space> /
 map <c-space> ?


 " Close the current buffer
 map <leader>bd :Bclose<cr>
 "
 " " Close all the buffers
 map <leader>ba :1,1000 bd!<cr>


 " Useful mappings for managing tabs
 map <leader>tn :tabnew<cr>
 map <leader>to :tabonly<cr>
 map <leader>tc :tabclose<cr>
 map <leader>tm :tabmove


 " Opens a new tab with the current buffer's path
 " " Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/


" Return to last edit position when opening files (You want this!)
 autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
 set viminfo^=%


 " Remap VIM 0 to first non-blank character
		 map 0 ^
		 

map <leader>g :vimgrep // **/*<left><left><left><left><left><left>

function! ReadEnc(filen)
    exe "r !cat " . a:filen . " | openssl enc -d -aes-256-cbc | gunzip -c"
endfunction
function! WriteEnc(filen)
    exe "1,$w !gzip -c | openssl enc -aes-256-cbc > " . a:filen
endfunction
function! DoTitle()
    exe "norm! yypv$r=o\<Esc>"
endfunction

map <F5> :call DoTitle()<CR>


function! CmdLine(str)
		    exe "menu Foo.Bar :" . a:str
			    emenu Foo.Bar
				    unmenu Foo
			endfunction

			function! VisualSelection(direction) range
					    let l:saved_reg = @"
						    execute "normal! vgvy"

							    let l:pattern = escape(@", '\\/.*$^~[]')
								    let l:pattern = substitute(l:pattern, "\n$", "", "")

									    if a:direction == 'b'
												        execute "normal ?" . l:pattern . "^M"
														    elseif a:direction == 'gv'
																	        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
																			    elseif a:direction == 'replace'
																						        call CmdLine("%s" . '/'. l:pattern . '/')
																								    elseif a:direction == 'f'
																											        execute "normal /" . l:pattern . "^M"
																													    endif

																														    let @/ = l:pattern
																															    let @" = l:saved_reg
																														endfunction
