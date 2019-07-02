"Global variables {{{

let MY_HOME = '/home/onceiusedwindows/'
let MY_VIM_PATH = MY_HOME . '.vim/'
let MY_TXT_FILES = MY_HOME . 'Documents/MyFiles/dc_GithubRepos/dot_files/.txt_files/'

let MY_SNIPPETS = MY_VIM_PATH . 'MySnippets/'
let MY_TEMPLATES = MY_TXT_FILES . 'templates/'
let MY_NOTES = MY_TXT_FILES . 'notes/'
let MY_SKELETONS = MY_TEMPLATES . 'skeletons/'

"}}}
" General settings {{{

"Enables line numbers
set number

"Disables word wrapping
set wrap

"Enables indentation when wrapping lines
set breakindent

"Use tab instead of spaces when pressing Tab
set noexpandtab

"Highlight the matching results when searching.
set incsearch

"99: Only folds with a depth level of 99 will not be opened, that is, most of the folds will be opened when opening a file.
"0: All folds will be closed.
set foldlevel=0

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

"}}}
"File settings {{{
"<F1>: Single file saving and raw compiling or interpretation.
"<F2>: Multiple file saving and raw compiling or interpretation.
"<F11>: Deletes files resulting from executing the source code.
"<F12>: See result or open resulting file.

"All files {{{

"Although you can specify configurations by specifying them in .vimrc, some plugins overwrite these configurations due to the configuration that is implemented within the files of a given plugin. For example, UltiSnips sets 'foldmethod=syntax' for files whose filetype is 'snippets'.

autocmd BufNewFile,BufRead * setlocal
	\ foldmethod=marker

"}}}
"(sass) SASS-CSS {{{

autocmd BufNewFile,BufRead *.sass setlocal
	\ expandtab

"}}}
"(python) Python {{{

autocmd BufNewFile,BufRead *.py setlocal
	\ expandtab
	\ foldmethod=marker
	\ foldlevel=99

autocmd filetype python nnoremap <buffer> <F7> :wa <bar> !clear && python3.7 % <CR>

"}}}
"(cpp) C++ {{{

autocmd BufNewFile,BufRead *.cpp setlocal
	\ foldmethod=syntax
	\ foldlevel=99

"Compiles and executes a cpp source file without using headers files regardless of the location of the file.
autocmd filetype cpp nnoremap <buffer> <F7> :wa <bar> !clear && g++ -std=gnu++14 -O2 % -o %:p:r.out && %:p:r.out<CR>

"}}}
"(tex) LaTeX {{{
"--output-directory: must be before the translation unit.

autocmd BufNewFile,BufRead,filetype tex
	\ highlight link texerror texabstract
	\ | nnoremap <buffer> <f1> :w <bar> :exec '!pdflatex --output-directory=' . shellescape(expand("%:h"), 1) . ' ' . shellescape(expand("%:.:p"), 1)<cr>
	\ | nnoremap <buffer> <F2> :wa <bar> :exec '!pdflatex --output-directory=' . shellescape(expand("%:h"), 1) . ' ' . shellescape(expand("%:.:p"), 1)<CR>
	\ | nnoremap <buffer> <F11> :!rm -rf *.pdf <bar> rm -rf *.log <bar> rm -rf *.aux <bar> rm -rf *.sta
	\ | nnoremap <buffer> <F12> :w <bar> :exec '!xdg-open ' . shellescape(expand('%:r') . '.pdf', 1) . ' &'<CR>

"}}}
"(gitignore) .gitignore {{{

autocmd BufNewFile,BufRead *.gitignore
	\ set filetype=gitignore

"}}}
"(html) HTML {{{

autocmd BufNewFile,BufRead,filetype html
	\ nnoremap <buffer> <F12> :exec '!google-chrome --new-window --args ' . shellescape(expand('%:p'), 1) . ' &'<CR><CR>

"}}}
"(markdown) Markdown {{{

autocmd BufNewFile,BufRead,filetype markdown
	\ nnoremap <buffer> <F12> :exec '!google-chrome --new-window --args ' . shellescape(expand('%:p'), 1) . ' &'<CR><CR>

"}}}

"}}}
"Highlighting {{{

"Cursor {{{
"Highlighting cursor makes Vim significantly slowly when working with some files.

"LineNR: Settings for line number on the left side.
"CursorLineNR: Settings for line number where the cursor is.
"CursorLine: Settings for the line where the cursor is.
"CursorColumn: Settings for the column where the cursor is.

highlight clear CursorLine
highlight LineNR ctermfg=64
highlight CursorLineNR ctermfg=11

"Enables/Disables the line row where the cursor is.
nnoremap <Leader>c :set cursorline!<CR>

"}}}
"Boxes {{{

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
"Keybindings {{{
"+info:
"	:help map-listing ()
"	:help key-notation (name with which 'Vim' recognizes keys.)

" (vmap) Visual and select mode {{{

"Replace spaces with underscores on visual selected text and unhighlights spaces.
vnoremap .. :s:\%V :_:g<CR>:noh<CR>

"Faster text replacement on visual selected text
vnoremap <Leader>r :s:\%V::g<Left><Left><Left>

"}}}
" (tmap) Terminal mode  {{{

"Disable the useless buffer moving
tnoremap <C-w><C-w> <Nop>

"Faster exiting from shell
tnoremap <Esc> <C-w><S-n>

"}}}
"(nmap) Normal mode {{{

"Miscelanous {{{

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

"}}}
"Manipulating the entire document {{{

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

"}}}
"Opening terminals {{{

"Open a terminal
nnoremap <Leader>t :term<CR>

"Open a terminal in the working directory where the file from the current buffer is.
nnoremap <Leader>tc :let $MY_VIM_VARIABLE=expand('%:p:h')<CR>:terminal<CR>cd $MY_VIM_VARIABLE<CR><C-l>

"}}}
" Quicker windows move {{{

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"}}}

"}}}
" (imap) Insert mode {{{

"Optimal keys {{{

"Delete the character behind the cursor position.
inoremap <C-d> <Del>

"Move (b)ackward.
inoremap <C-b> <Left>

"Move (f)orward.
inoremap <C-f> <Right>

"}}}
"Auto closing openers {{{

"It doesn't write the closing openers if it's already present

inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

inoremap        [  []<Left>
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

"}}}

"}}}
" (cmap) Command line editting mode {{{
" +info:
" 	:help ex-edit-index

"Go to the beginning of the line
cnoremap <C-a> <C-b>

" Go (f)orward
cnoremap <C-f> <Right>

" Go (b)ackward
cnoremap <C-b> <Left>

"Cursor one word right (if in command-line selecting, it will choose the current selected option)
cnoremap <C-o> <S-Right>

"Cursor one word left.
cnoremap <C-z> <S-Left>

"Save the 'Control + d' key (which list completions that match the apttern in front of the cursor)
cnoremap <C-x> <C-d>

"Delete the character behind the cursor position.
cnoremap <C-d> <Del>

"Disables <C-m> and 'Enter' to use 'Control+J' instead.
cnoremap <C-m> <Nop>

"Disables '<BS>' to use 'Control+H' instead.
cnoremap <BS> <Nop>

"}}}
"(omap) Operator-pending mode {{{



"}}}
" (xmap) Visual mode {{{



"}}}
" (smap) Select mode {{{



"}}}
" (lmap) Insert and command line editing mode {{{


"}}}
"I'm not incompetent {{{

function IncompetentMsg(...)
	let a:beginning = "YOU INCOMPETENT, use "
	let a:end = "!"

	"If number or arguments equals 1.
	if a:0 == 1
		return a:beginning . "'" . a:1 . "'" . a:end
	else
		return a:beginning . a:1 . a:end
endfunction

let key_move_down = 	IncompetentMsg("j")
let key_move_up = 		IncompetentMsg("k")
let key_move_left = 	IncompetentMsg("h")
let key_move_right = 	IncompetentMsg("l")
let key_backspace = 	IncompetentMsg("Control+h")
let key_enter = 		IncompetentMsg("Control+j")

"Disable arrows for moving in normal mode
noremap <Up> :echoe key_move_up<CR>
noremap <Down> :echoe key_move_down<CR>
noremap <Left> :echoe key_move_left<CR>
noremap <Right> :echoe key_move_right<CR>

"Disable arrows for moving in insert mode
inoremap <Up> <Esc>:echoe key_move_up<CR>
inoremap <Down> <Esc>:echoe key_move_down<CR>
inoremap <Left> <Esc>:echoe key_move_left<CR>
inoremap <Right> <Esc>:echoe key_move_right<CR>

inoremap <BS> <Esc>:echoe key_backspace<CR>
inoremap <CR> <Esc>:echoe key_enter<CR>

"I'm not messing with you, I'm not incompetent
" nnoremap h <Esc>:echoe "YOU INCOMPETENT, USE b"<CR>
" nnoremap k <Esc>:echoe "YOU INCOMPETENT, USE 'Number+G', 'Control+Y', 'Control+U' or 'Control+P'"<CR>
" nnoremap j <Esc>:echoe "YOU INCOMPETENT, USE 'Number+G', 'Control+E' or 'Control+D'"<CR>
" nnoremap l <Esc>:echoe "YOU INCOMPETENT, USE e AND w"<CR>

"}}}

"}}}
