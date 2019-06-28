"Global variables {{{1

let g:MY_HOME = '/home/onceiusedwindows/'
let g:MY_VIM_PATH = MY_HOME . '.vim/'
let g:MY_TXT_FILES = MY_HOME . 'Documents/MyFiles/dc_GithubRepos/dot_files/.txt_files/'

let g:MY_SNIPPETS = MY_VIM_PATH . 'MySnippets/'
let g:MY_TEMPLATES = MY_TXT_FILES . 'templates/'
let g:MY_NOTES = MY_TXT_FILES . 'notes/'
let g:MY_SKELETONS = MY_TEMPLATES . 'skeletons/'

"}}}1

" General settings {{{1

"Enables line numbers
set number

"Disables word wrapping
set wrap

"Enables indentation when wrapping lines
set breakindent

"Determines what kind of folding to apply
set foldmethod=marker

"Use tab instead of spaces when pressing Tab
set noexpandtab

"Highlight the matching results when searching.
set incsearch

"All folds are not opened when opening a new file
set foldlevel=99

"Number of spaces that a <Tab> in the file counts for
set tabstop=4

"Highlight all ocurrences of a pattern that has been searched.
set hlsearch

"Allows input of character that are difficult to type when using an english keyboard.
set digraph

"Set number of lines that are used as a padding between the vertical borders and the cursor
set scrolloff=999

"Displays status line always. It allows you to see the current mode, file name, file status, ruler, etc.
set laststatus=2

"Shows a menu when trying to open another file from Vim's terminal and there are files available to be opened.
set wildmenu

"Set the number of spaces that are used when autoindenting new lines or when indenting multiple selected lines using '>' or '<'.
set shiftwidth=4

"Allow backspacing over autoindent, line breaks (join lines), start of insert. In simpler words, it makes backspace behave properly in insert mode.
set backspace=indent,eol,start

"If you search for something containing uppercase characters, it will do a case sensitive search; if you search for something purely lowercase, it will do a case insensitive search.
set smartcase

"Enables syntax highlighting
syntax on

"Makes Vim not to flush the clipboard register when Vim is closed.
autocmd VimLeave * call system("xclip -selection clipboard", getreg('+'))

"Changes the default behaviour of Vim to set .tex files to a filetype different to the latex filetype.
let g:tex_flavor="latex" 

"}}}1

"File settings {{{1

" All files {{{2

"Although you can specify configurations by specifying them in .vimrc, some plugins overwrite these configurations due to the configuration that is implemented within the files of a given plugin. For example, UltiSnips sets 'foldmethod=syntax' for files whose filetype is 'snippets'.

autocmd BufNewFile,BufRead * setlocal
	\ foldmethod=marker

"}}}2

" SASS-CSS {{{2

autocmd BufNewFile,BufRead *.sass setlocal
	\ expandtab

"}}}2

"Python {{{2

autocmd BufNewFile,BufRead *.py setlocal
	\ expandtab
	\ foldmethod=indent
	\ foldlevel=99

"}}}2

"C++ {{{2

autocmd BufNewFile,BufRead *.cpp setlocal
	\ foldmethod=syntax
	\ foldlevel=99

"}}}2

"LaTeX {{{2

autocmd BufNewFile,BufRead *.tex 
	\ highlight link texError texAbstract

"}}}2

".gitignore {{{2

autocmd BufNewFile,BufRead *.gitignore
	\ set filetype=gitignore

"}}}2

"}}}1

"Highlighting {{{1

"Cursor {{{2

"Makes vim slow when working with '.tex' files.

"Enable cursor line position tracking
"set cursorline
"Remove the underline from enabling cursorline
"highlight clear CursorLine
"Set line numbering to gray background
"highlight CursorLineNR ctermbg=gray

"}}}

"Boxes {{{2

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

"}}}

"}}}

"Keybindings {{{1

"Visual mode {{{2

"Replace spaces with underscores on visual selected text and unhighlights spaces.
vnoremap .. :s:\%V :_:g<CR>:noh<CR>

"Faster text replacement on visual selected text
vnoremap <Leader>r :s:\%V::g<Left><Left><Left>

"}}}2

"Terminal mode {{{2

"Disable the useless buffer moving
tnoremap <C-w><C-w> <Nop>

"}}}2

"Normal mode {{{2

"Miscelanous {{{3

"Go to the middle of the current selected line
nnoremap <Leader>v :call cursor(0, len(getline('.'))/2+1)<CR>

"Better screen centering
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

"word wrapping activator
"au BufAdd * if &wrap | set wrap | else | set nowrap | endif
nnoremap <Leader>w :windo set wrap!<CR>

"Change the current working directory to the directory in which the current file is.
"'ch' stands for '(c)hange (d)irectory'
nnoremap <Leader>ch :exe ":chdir " . expand("%:p:h") <CR>

"Copy full path from the file from the current buffer to the CLIPBOARD
"'cp' stands for '(c)opy (p)ath'
nnoremap <Leader>cp :let @+ = expand("%:p")<CR>

"Disable the useless buffer moving.
nnoremap <C-w><C-w> <Nop>

" File skeleton inserter
nnoremap <Leader><Space> :exe ":-1read " . MY_SKELETONS . &filetype<CR>

"}}}3

"Manipulating the entire document {{{3

"Copy all content from the file into primary clipboard
"'ca' stands for '(c)opy (a)ll'
nnoremap <Leader>ca :% y+<CR>

"Deletes all content from the file.
"'da' stands for '(d)elete (a)ll'
nnoremap <Leader>da ggdG

"Select all content from the file.
"'sa' stands for '(s)elect (a)ll'
nnoremap <Leader>sa GVggzz

"Paste the content of the CLIPBOARD buffer.
"'p' stands for '(p)aste' \(0o0)/
nnoremap <Leader>p "+p

"}}}3

"Terminal {{{3

"Open a terminal
nnoremap <Leader>t :term<CR>

"Open a terminal in the working directory where the file from the current buffer is.
nnoremap <Leader>tc :let $MY_VIM_VARIABLE=expand('%:p:h')<CR>:terminal<CR>cd $MY_VIM_VARIABLE<CR><C-l>

"}}}3

"Faster indentation {{{3

nnoremap > >>
nnoremap < <<

"}}}3

"Executing translation units {{{3

autocmd filetype python nnoremap <buffer> <F7> :wa <bar> !clear && python3.7 % <CR>
"Compiles and executes a cpp source file without using headers files regardless of the location of the file.
autocmd filetype cpp nnoremap <buffer> <F7> :wa <bar> !clear && g++ -std=gnu++14 -O2 % -o %:p:r.out && %:p:r.out<CR>

"Compiles a tex file using 'pdflatex'
autocmd fileType tex nnoremap <F9> :w <bar> :exec '!pdflatex --shell-escape -output-directory=' . shellescape(expand("%:p:h")) . ' ' . shellescape(expand("%:p"), 1)<CR>
"Open the pdf resulting of having compiled the 'pdflatex'
autocmd fileType tex nnoremap <F10> :w <bar> :exec '!xdg-open ' . shellescape(expand('%:r') . '.pdf', 1) . ' &'<CR>

"}}}3

" Quicker windows move {{{3

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"}}}3

"}}}2

"Insert mode {{{2

"Auto closing openers {{{3

"It doesn't write the closing openers if it's already present

inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

inoremap        [  []<Left>
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

"}}}3

" Miscelanous {{{3

"Delete key using the keys from the main keyboard
inoremap <C-b> <Del>

"}}}3

"}}}2

"I'm not incompetent {{{2

"Disable arrows for moving in normal mode
noremap <Up> :echoe "YOU INCOMPETENT, USE k"<CR>
noremap <Down> :echoe "YOU INCOMPETENT, USE j"<CR>
noremap <Left> :echoe "YOU INCOMPETENT, USE h"<CR>
noremap <Right> :echoe "YOU INCOMPETENT, USE l"<CR>

"Disable arrows for moving in insert mode
inoremap <Up> <Esc>:echoe "YOU INCOMPETENT, USE k"<CR>
inoremap <Down> <Esc>:echoe "YOU INCOMPETENT, USE j"<CR>
inoremap <Left> <Esc>:echoe "YOU INCOMPETENT, USE h"<CR>
inoremap <Right> <Esc>:echoe "YOU INCOMPETENT, USE l"<CR>

"Disable 'Enter' key so that it doesn't enter a newline in insert mode.
inoremap <BS> <Esc>:echoe "YOU INCOMPETENT, USE 'Control+h'"<CR>
"Disable 'Backspace' so that it doesn't delete characters in insert mode.
nnoremap <BS> <Esc>:echoe "YOU INCOMPETENT, WHY ARE YOU USING BACKSPACE IN NORMAL MODE?"<CR>

"Disable 'Enter' key so that it doesn't enter a newline in insert mode.
inoremap <CR> <Esc>:echoe "YOU INCOMPETENT, USE 'Control+j'"<CR>
"Disable 'Enter' key so that it doesn't go to the line below while in normal mode
nnoremap <CR> <Esc>:echoe "YOU INCOMPETENT, WHY ARE YOU USING ENTER IN NORMAL MODE?"<CR>

"I'm not messing with you, I'm not incompetent
" nnoremap h <Esc>:echoe "YOU INCOMPETENT, USE b"<CR>
" nnoremap k <Esc>:echoe "YOU INCOMPETENT, USE 'Number+G', 'Control+Y', 'Control+U' or 'Control+P'"<CR>
" nnoremap j <Esc>:echoe "YOU INCOMPETENT, USE 'Number+G', 'Control+E' or 'Control+D'"<CR>
" nnoremap l <Esc>:echoe "YOU INCOMPETENT, USE e AND w"<CR>

"}}}2

"}}}1
