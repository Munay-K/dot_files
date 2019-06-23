" !1| --------------------------------------------------
" !1| General settings
" !1| --------------------------------------------------

"Enables line numbers
set number

"Disables word wrapping
set wrap

"Enables indentation when wrapping lines
set breakindent

"Determines what kind of folding to apply
set foldmethod=manual

"Use tab instead of spaces when pressing Tab
set noexpandtab

"Highlight the matching results when searching.
set incsearch

" Number of spaces that a <Tab> in the file counts for
set tabstop=4

"Highlight all ocurrences of a pattern that has been searched.
set hlsearch

"Allows input of character that are difficult to type when using an english keyboard.
set digraph

"Displays status line always. It allows you to see the current mode, file name, file status, ruler, etc.
set laststatus=2

"Shows a menu when trying to open another file from Vim's terminal and there are files available to be opened.
set wildmenu

"Allow backspacing over autoindent, line breaks (join lines), start of insert. In simpler words, it makes backspace behave properly in insert mode.
set backspace=indent,eol,start

"If you search for something containing uppercase characters, it will do a case sensitive search; if you search for something purely lowercase, it will do a case insensitive search.
set smartcase

"Enables syntax highlighting
syntax on

" Makes wVim not to flush the clipboard register when Vim is closed.
autocmd VimLeave * call system("xclip -selection clipboard", getreg('+'))

" !1| --------------------------------------------------
" !1| File settings
" !1| --------------------------------------------------

"expandtab: Use spaces instead of '\t' when pressing Tab
"shiftwidth: Set the number of spaces to use when indenting multiple selected lines using '>' or '<'

autocmd BufNewFile,BufRead,WinEnter *.sass
	\ setlocal expandtab
	\ | setlocal shiftwidth=4

autocmd BufNewFile,BufRead,WinEnter *.py
	\ setlocal expandtab
	\ | setlocal shiftwidth=4

" !1| --------------------------------------------------
" !1| Highlighting
" !1| --------------------------------------------------


" !2| --------------------------------------------------
" !2| Cursor
" !2| --------------------------------------------------

"Makes vim slow when working with '.tex' files.

" Enable cursor line position tracking
" set cursorline
" Remove the underline from enabling cursorline
" highlight clear CursorLine
" Set line numbering to gray background
" highlight CursorLineNR ctermbg=gray

" !2| --------------------------------------------------
" !2| Separators
" !2| --------------------------------------------------

highlight separator_3 cterm=bold ctermbg=022 ctermfg=015
highlight separator_2 cterm=bold ctermbg=028 ctermfg=015
highlight separator_1 cterm=bold ctermbg=034 ctermfg=015

" It will match from 0 to 3 character before the separator.
" It is important to consider that regex don't overlap.
autocmd BufNewFile,BufRead,WinEnter *
	\ call matchadd('separator_1', '^.\{0,3\}!1| .*')
	\ | call matchadd('separator_2', '^.\{0,3\}!2| .*')
	\ | call matchadd('separator_3', '^.\{0,3\}!3| .*')

" !2| --------------------------------------------------
" !2| Boxes
" !2| --------------------------------------------------

highlight boxes ctermbg=243 ctermfg=015

autocmd BufNewFile,BufRead,WinEnter *
	\   call matchadd('boxes', '^.\{0,3\}█▀\{1,}█')
	\ | call matchadd('boxes', '^.\{0,3\}▌ .* ▐')
	\ | call matchadd('boxes', '^.\{0,3\}█▄\{1,}█')
	\
	\ | call matchadd('boxes', '^.\{0,3\}╔═\{1,}╗')
	\ | call matchadd('boxes', '^.\{0,3\}║ .* ║')
	\ | call matchadd('boxes', '^.\{0,3\}╚═\{1,}╝')
	\
	\ | call matchadd('boxes', '^.\{0,3\}┌─\{1,}┐')
	\ | call matchadd('boxes', '^.\{0,3\}│ .* │')
	\ | call matchadd('boxes', '^.\{0,3\}└─\{1,}┘')

" !1| --------------------------------------------------
" !1| Keybindings
" !1| --------------------------------------------------

" !2| --------------------------------------------------
" !2| Normal mode
" !2| --------------------------------------------------

" !3| --------------------------------------------------
" !3| All file content
" !3| --------------------------------------------------

" Copy all content from the file into primary clipboard
" 'ca' stands for '(c)opy (a)ll'
nnoremap <Leader>ca :% y+<CR>

" Deletes all content from the file.
" 'da' stands for '(d)elete (a)ll'
nnoremap <Leader>da ggdG

" Select all content from the file.
" 'sa' stands for '(s)elect (a)ll'
nnoremap <Leader>sa GVggzz

" !3| --------------------------------------------------
" !3| Terminal
" !3| --------------------------------------------------

" It opens a terminal
nnoremap <Leader>t :term<CR>

" It opens a terminal in the working directory where the file from the current buffer is.
nnoremap <Leader>tc :let $MY_VIM_VARIABLE=expand('%:p:h')<CR>:terminal<CR>cd $MY_VIM_VARIABLE<CR><C-l>

" !3| --------------------------------------------------
" !3| Miscelanous
" !3| --------------------------------------------------

" Go to the middle of the current selected line
nnoremap <Leader>v :call cursor(0, len(getline('.'))/2+1)<CR>

" Better screen centering
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" word wrapping activator
nnoremap <Leader>w :set wrap!<CR>

" Change the current working directory to the directory in which the current file is.
nnoremap <Leader>ch :exe ":chdir " . expand("%:p:h") <CR>

" Make vim search all ocurrences of a word and don't go to the next word.
nnoremap # viw""y/\<<C-r>"\><CR>N

" Copy full path from the file from the current buffer to the CLIPBOARD
nnoremap <Leader>cp :let @+ = expand("%:p")<CR>

" !2| --------------------------------------------------
" !2| Compiling/interpreting translation units
" !2| --------------------------------------------------

" Interprets a python file using the version that is specified in the command.
autocmd filetype python nnoremap <F7> :w <bar> !clear && python3.7 % <CR>
" Compiles and executes a cpp source file without using headers files
autocmd filetype cpp nnoremap <F7> :w <bar> !clear && g++ -std=gnu++14 -O2 % -o %:p:h/%:t:r.exe && ./%:r.exe<CR>

" Compiles a tex file using 'pdflatex'
autocmd fileType tex nnoremap <F9> :w <bar> :exec '!pdflatex --shell-escape -output-directory=' . shellescape(expand("%:p:h")) . ' ' . shellescape(expand("%:p"), 1)<CR>
" Open the pdf resulting of having compiled the 'pdflatex'
autocmd fileType tex nnoremap <F10> :w <bar> :exec '!xdg-open ' . shellescape(expand('%:r') . '.pdf', 1) . ' &'<CR>

" !3| --------------------------------------------------
" !3| File skeleton inserter
" !3| --------------------------------------------------

nnoremap <Leader><Space> :exe ":-1read $HOME/Documents/MyFiles/dc_GithubRepos/dot_files/.txt_files/templates/skeletons/" . expand('%:e')<CR>

" !2| --------------------------------------------------
" !2| Quicker windows move
" !2| --------------------------------------------------
" It doesn't work appropiately when working with the terminal

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" !2| --------------------------------------------------
" !2| Insert mode
" !2| --------------------------------------------------

" !3| --------------------------------------------------
" !3| Auto closing braces [] and parentheses ()
" !3| --------------------------------------------------

" It doesn't write the closing parentheses if it's already present

inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

inoremap        [  []<Left>
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

" !2| --------------------------------------------------
" !2| Miscelanous
" !2| --------------------------------------------------

" !3| --------------------------------------------------
" !3| Disabling arrows for moving
" !3| --------------------------------------------------

noremap <Up> 	:echoe "YOU INCOMPETENT, USE k"<CR>
noremap <Down> 	:echoe "YOU INCOMPETENT, USE j"<CR>
noremap <Left> 	:echoe "YOU INCOMPETENT, USE h"<CR>
noremap <Right> :echoe "YOU INCOMPETENT, USE l"<CR>

inoremap <Up> 		<Esc>:echoe "YOU INCOMPETENT, USE k"<CR>
inoremap <Down> 	<Esc>:echoe "YOU INCOMPETENT, USE j"<CR>
inoremap <Left> 	<Esc>:echoe "YOU INCOMPETENT, USE h"<CR>
inoremap <Right>	<Esc>:echoe "YOU INCOMPETENT, USE l"<CR>

" !2| --------------------------------------------------
" !2| Visual mode
" !2| --------------------------------------------------

" Replace spaces with underscores on visual selected text and unhighlights spaces.
vnoremap .. :s:\%V :_:g<CR>:noh<CR>
" Faster text replacement on visual selected text
vnoremap <Leader>r :s:\%V::g<Left><Left><Left>
