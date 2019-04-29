" -------------------------------------------------------
" VUNDLE REQUIREMENTS (DONT'T TOUCH)
"--------------------------------------------------------

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'SirVer/ultisnips' "Snippets
Plugin 'scrooloose/nerdtree' "File manager 
Plugin 'xuhdev/vim-latex-live-preview'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on 
" ///////////////////////////////////////////////////////
" -------------------------------------------------------
"  Settings:
" -------------------------------------------------------
" ///////////////////////////////////////////////////////

" -------------------------------------------------------
" Settings: General
" -------------------------------------------------------

set number				"Enables line numbers
set tabstop=4			"Changes the number of visual space per tab
set shiftwidth=4 		"Changes the number of spaces to use for each step of (auto)indent to 4, the default value is 8.
set wrap				"Disables word wrapping
set breakindent			"Enables indentation when wrapping
set laststatus=2		"Displays status line always. It allows you to see the current mode, file name, file status, ruler, etc.
colorscheme industry		"Scheme for entire vim

" -------------------------------------------------------
" Settings: Cursor highlighting
"--------------------------------------------------------

"Enable cursor line position tracking
set cursorline
"Remove the underline from enabling cursorline
highlight clear CursorLine
"Set line numbering to gray background
highlight CursorLineNR ctermbg=gray

" -------------------------------------------------------
" Settings: Plugin: vim-instant-markdown
" -------------------------------------------------------

let g:instant_markdown_autostart = 0 	"It makes the preview window not to be launched automatically. :InstantMarkdownPreview will enable that window.
let g:instant_markdown_slow = 0 		"It makes vim-instant-markdown not to refresh each second so as to avoid unneecesary computer resources.

" -------------------------------------------------------
" Settings: Plugin: UltiSnips
" -------------------------------------------------------

let g:UltiSnipsSnippetDirectories=["MySnippets"] 	"Specifies the directories which are going to be searched by Vim when looking for snippets.
let g:tex_flavor="latex" 							"By default, Vim sets ft=plaintex for empty .tex files, which can be changed with this

" -------------------------------------------------------
" Settings: Plugin: NERDTree
" -------------------------------------------------------

let g:NERDTreeWinPos = "right" 		"Always open NERDTree on the right side

" ///////////////////////////////////////////////////////
" -------------------------------------------------------
" Keybindings:
" -------------------------------------------------------
" ///////////////////////////////////////////////////////

map <C-m> :call UltiSnips#RefreshSnippets()

" -------------------------------------------------------
" Keybindings: Deactivators
" -------------------------------------------------------

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" -------------------------------------------------------
" Keybindings: Compilation and processing of programming languages
" -------------------------------------------------------

autocmd filetype cpp nnoremap <F7> :w <bar> !clear && g++ -std=gnu++14 -O2 % -o %:p:h/%:t:r.exe && ./%:r.exe<CR>
autocmd filetype tex nnoremap <F7> :w <bar> !pdflatex % && xdg-open %:t:r.pdf<CR>

autocmd filetype perl nnoremap <F7> :w <bar> !perl % <CR>
autocmd filetype go nnoremap <F7> :w <bar> !go build % && ./%:p <CR>
autocmd filetype js nnoremap <F7> :w <bar> !node % <CR>
autocmd filetype c nnoremap <F7> :w <bar> !clear && gcc -std=c99 -Wall -Werror -Wextra -lm % -o %:p:h/%:t:r.out && ./%:r.out<CR>
autocmd filetype java nnoremap <F7> :w <bar> !javac % && java -enableassertions %:p <CR>
autocmd filetype python nnoremap <F7> :w <bar> !clear && python3.7 % <CR>
" -------------------------------------------------------
"  Keybindings: Plugin: NERDTree
" -------------------------------------------------------

" Paste the :NERDTree in the vim command line
:map <C-n> :NERDTree

