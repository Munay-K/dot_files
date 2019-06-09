" ------------------------------------------------------------
" _[1]_ General settings
" ------------------------------------------------------------

set number								"Enables line numbers
set wrap								"Disables word wrapping
syntax on								"Enables syntax highlighting
set breakindent							"Enables indentation when wrapping
set tabstop=4							"Changes the number of visual space per tab
set hlsearch							"Highlight ocurrences of a pattern when searching
set foldmethod=manual					"Determines what kind of folding applies in the current window
set digraph								"Allows input of character that normally cannot be entered by an ordinary keyboard.
set shiftwidth=4 						"Changes the number of spaces to use for each step of (auto)indent to 4, the default value is 8.
set laststatus=2						"Displays status line always. It allows you to see the current mode, file name, file status, ruler, etc.
set backspace=indent,eol,start			"Allow backspacing over autoindent, line breaks (join lines), start of insert. In simpler words, it makes backspace behave properly in insert mode.

" ------------------------------------------------------------
" _[1]_ Cursor highlighting
" ------------------------------------------------------------
" Makes vim slow when working with '.tex' files

"Enable cursor line position tracking
"set cursorline
"Remove the underline from enabling cursorline
"highlight clear CursorLine
"Set line numbering to gray background
"highlight CursorLineNR ctermbg=gray

" ------------------------------------------------------------
" _[1]_ Clipboard settings
" ------------------------------------------------------------

" Makes Vim not to flusht the buffer when is closed.
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" ------------------------------------------------------------
" _[1]_ Keybindings
" ------------------------------------------------------------

" Copy all the content of the file inro primary clipboard
" nnoremap <Leader>ca ggVG"+y<CR>
nnoremap <Leader>ca :% y+<CR>

" Changes the current working directory to the directory of the file being edited in current buffer
nnoremap <Leader>ch :exe ":chdir " . expand("%:p:h") <CR>

" ------------------------------------------------------------
" _[2]_ Disabling arrows for moving
" ------------------------------------------------------------

noremap <Up> 	:echoe "YOU INCOMPETENT, USE k"<CR>
noremap <Down> 	:echoe "YOU INCOMPETENT, USE j"<CR>
noremap <Left> 	:echoe "YOU INCOMPETENT, USE h"<CR>
noremap <Right> :echoe "YOU INCOMPETENT, USE l"<CR>

inoremap <Up> 		<Esc>:echoe "YOU INCOMPETENT, USE k"<CR>i
inoremap <Down> 	<Esc>:echoe "YOU INCOMPETENT, USE j"<CR>i
inoremap <Left> 	<Esc>:echoe "YOU INCOMPETENT, USE h"<CR>i
inoremap <Right>	<Esc>:echoe "YOU INCOMPETENT, USE l"<CR>i

" ------------------------------------------------------------
" _[2]_ Quicker windows move
" ------------------------------------------------------------
" It doesn't work appropiately when working with the terminal

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" ------------------------------------------------------------
" _[2]_ Executing source code
" ------------------------------------------------------------

" Interprets a python file using the version that is specified in the command.
autocmd filetype python nnoremap <F7> :w <bar> !clear && python3.7 % <CR>
" Compiles and executes a cpp source file without using headers files
autocmd filetype cpp 	nnoremap <F7> :w <bar> !clear && g++ -std=gnu++14 -O2 % -o %:p:h/%:t:r.exe && ./%:r.exe<CR>

" Compiles a tex file using 'pdflatex'
autocmd fileType tex 	nnoremap <F9> :w <bar> :exec '!pdflatex --shell-escape -output-directory=' . shellescape(expand("%:p:h")) . ' ' . shellescape(expand("%:p"), 1)<CR>
" Open the pdf resulting of having compiled the 'pdflatex'
autocmd fileType tex 	nnoremap <F10> :w <bar> :exec '!xdg-open ' . shellescape(expand('%:r') . '.pdf', 1) . ' &'<CR>

" ------------------------------------------------------------
" _[2]_ Files skeletons
" ------------------------------------------------------------

" Simple skeleton inserter
" autocmd fileType tex nnoremap <buffer> <Leader>m :-1read $HOME/.vim/skeletons/tex<CR>

" Generic skeleton inserter
:nnoremap <Leader><Space> :exe ":-1read $HOME/.vim/templates/skeletons/" . expand('%:e')<CR>

" ------------------------------------------------------------
" _[2]_ Auto-closing braces [] and parentheses ()
" ------------------------------------------------------------
" It doesn't write the closing parentheses if it's already present

inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap        [  []<Left>
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"


" ------------------------------------------------------------
" _[2]_ Miscelanous
" ------------------------------------------------------------

" Go to the middle of the line
nnoremap <Leader>v :call cursor(0, len(getline('.'))/2+1)<CR>
