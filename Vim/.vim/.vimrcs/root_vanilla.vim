"Global variables {{{1

let MY_HOME = '/home/onceiusedwindows/'
let MY_VIM_PATH = MY_HOME . '.vim/'
let MY_TXT_FILES = MY_HOME . 'Documents/MyFiles/dc_GithubRepos/dot_files/.txt_files/'

let MY_SNIPPETS = MY_VIM_PATH . 'MySnippets/'
let MY_TEMPLATES = MY_TXT_FILES . 'templates/'
let MY_NOTES = MY_TXT_FILES . 'notes/'
let MY_SKELETONS = MY_TEMPLATES . 'skeletons/'

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
"	:help map-listing

" (vmap) Visual and select mode {{{

"Replace spaces with underscores on visual selected text and unhighlights spaces.
vnoremap .. :s:\%V :_:g<CR>:noh<CR>

"Faster text replacement on visual selected text
vnoremap <Leader>r :s:\%V::g<Left><Left><Left>

"}}}

" (tmap) Terminal mode  {{{

"Disable the useless buffer moving
tnoremap <C-w><C-w> <Nop>

"Faster searching
tnoremap <Leader>s <C-w><S-n>/

"}}}

" (imap) Insert mode {{{

"Miscelanous {{{

"Delete the character behind the cursor position.
inoremap <C-d> <Del>

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

"Delete all characters regardless of the cursor position
cnoremap <C-u> <C-e><C-u>

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

"I'm not incompetent {{{2

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

"}}}2

"}}}
