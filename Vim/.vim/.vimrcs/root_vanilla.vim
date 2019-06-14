" !1| General settings !1|

set number								"Enables line numbers
set wrap								"Disables word wrapping
syntax on								"Enables syntax highlighting
set breakindent							"Enables indentation when wrapping
set tabstop=4							"Changes the number of visual space per tab
set hlsearch							"Highlight ocurrences of a pattern when searching
set foldmethod=manual					"Determines what kind of folding applies in the current window
set digraph								"Allows input of character that are difficult to type when using an english keyboard.
set shiftwidth=4 						"Changes the number of spaces to use for each step of (auto)indent to 4, the default value is 8.
set laststatus=2						"Displays status line always. It allows you to see the current mode, file name, file status, ruler, etc.
set backspace=indent,eol,start			"Allow backspacing over autoindent, line breaks (join lines), start of insert. In simpler words, it makes backspace behave properly in insert mode.
set smartcase							"If you search for something containing uppercase characters, it will do a case sensitive search; if you search for something purely lowercase, it will do a case insensitive search.

" !1| Cursor highlighing !1|
" Makes vim slow when working with '.tex' files

"Enable cursor line position tracking
"set cursorline
"Remove the underline from enabling cursorline
"highlight clear CursorLine
"Set line numbering to gray background
"highlight CursorLineNR ctermbg=gray

" !1| Clipboard settings !1|

" Makes Vim not to flush the clipboard buffer when is closed.
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" !1| Keybindings !1|

" Copy all the content of the file into primary clipboard
nnoremap <Leader>ca :% y+<CR>

" Delete all the file content
nnoremap <Leader>da ggdGi<CR>

" Change the current working directory to the directory in which the current file is.
nnoremap <Leader>ch :exe ":chdir " . expand("%:p:h") <CR>

" !2| Disable arrows for moving !2|

noremap <Up> 	:echoe "YOU INCOMPETENT, USE k"<CR>
noremap <Down> 	:echoe "YOU INCOMPETENT, USE j"<CR>
noremap <Left> 	:echoe "YOU INCOMPETENT, USE h"<CR>
noremap <Right> :echoe "YOU INCOMPETENT, USE l"<CR>

inoremap <Up> 		<Esc>:echoe "YOU INCOMPETENT, USE k"<CR>i
inoremap <Down> 	<Esc>:echoe "YOU INCOMPETENT, USE j"<CR>i
inoremap <Left> 	<Esc>:echoe "YOU INCOMPETENT, USE h"<CR>i
inoremap <Right>	<Esc>:echoe "YOU INCOMPETENT, USE l"<CR>i

" !2| Quicker windows move !2|
" It doesn't work appropiately when working with the terminal

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" !2| Better moving on splitted lines !2|
" Makes vim a little bit slower

" nnoremap j gj
" nnoremap k gk

" !2| Compiling/interpreting translation units !2|

" Interprets a python file using the version that is specified in the command.
autocmd filetype python nnoremap <F7> :w <bar> !clear && python3.7 % <CR>
" Compiles and executes a cpp source file without using headers files
autocmd filetype cpp 	nnoremap <F7> :w <bar> !clear && g++ -std=gnu++14 -O2 % -o %:p:h/%:t:r.exe && ./%:r.exe<CR>

" Compiles a tex file using 'pdflatex'
autocmd fileType tex 	nnoremap <F9> :w <bar> :exec '!pdflatex --shell-escape -output-directory=' . shellescape(expand("%:p:h")) . ' ' . shellescape(expand("%:p"), 1)<CR>
" Open the pdf resulting of having compiled the 'pdflatex'
autocmd fileType tex 	nnoremap <F10> :w <bar> :exec '!xdg-open ' . shellescape(expand('%:r') . '.pdf', 1) . ' &'<CR>

" !2| Files skeletons !2|

" Simple skeleton inserter
" autocmd fileType tex nnoremap <buffer> <Leader>m :-1read $HOME/.vim/skeletons/tex<CR>

" Generic skeleton inserter
nnoremap <Leader><Space> :exe ":-1read $HOME/.vim/templates/skeletons/" . expand('%:e')<CR>

" !2| Auto-closing braces [] and parentheses () !2|

" It doesn't write the closing parentheses if it's already present

inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

inoremap        [  []<Left>
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

" !2| Miscelanous !2|

" Go to the middle of the current selected line
nnoremap <Leader>v :call cursor(0, len(getline('.'))/2+1)<CR>
" Fastest search and replace
nnoremap ;; :%s:::g<Left><Left><Left>
" Better screen centering
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" Search separator patterns (see my Ultisnips snippets from the 'all' section for a better understanding)
nnoremap <Leader>s1 /.\+!1\| .\+ !1\|<CR>
nnoremap <Leader>s2 /.\+!2\| .\+ !2\|<CR>
nnoremap <Leader>s3 /.\+!3\| .\+ !3\|<CR>
nnoremap <Leader>s4 /.\+!4\| .\+ !4\|<CR>
nnoremap <Leader>s5 /.\+!5\| .\+ !5\|<CR>
nnoremap <Leader>s6 /.\+!6\| .\+ !6\|<CR>
nnoremap <Leader>s7 /.\+!7\| .\+ !7\|<CR>
nnoremap <Leader>s8 /.\+!8\| .\+ !8\|<CR>
nnoremap <Leader>s9 /.\+!9\| .\+ !9\|<CR>
nnoremap <Leader>sa /.\+!\d\+\|.\+!\d\+\|<CR>
