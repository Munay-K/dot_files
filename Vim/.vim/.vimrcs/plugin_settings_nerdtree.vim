" General {{{1

" Always open NERDTree on the right side
let g:NERDTreeWinPos = "right"

" Disables the 'Bookmarks' label 'Press ? for helpἀ text.
let NERDTreeMinimalUI = 1

"}}}1
"Keybindings {{{1

"Default {{{2

" Faster file opening or also known as 'ranger' file opening.
" Use l to open directories and files within the NERDTree menu, the default value is 'o'.
let NERDTreeMapActivateNode = 'l'

" Tells the NERDTree whether to display hidden files on startup.
let NERDTreeShowHidden = 1

"}}}2
"Custom {{{2

" Open the NERDTree menu.
nnoremap <C-n> :NERDTree<CR>

" Open (n)erd (t)ree in my (t)emplates folder for a given (f)iletype
" If filetype is empty, the 'templates' folder will be opened.
" If there are no folder for a given filetype, NERDTree will not be opened.
nnoremap <Leader>nttf :exe ":NERDTree " . MY_TEMPLATES . &filetype<CR>

" Open (n)erd (t)ree in my (t)emplates folder (regardless of the file type)
nnoremap <Leader>ntt :exe ":NERDTree " . MY_TEMPLATES <CR>

" Open (n)erd (t)ree in my (s)nippets folder
nnoremap <Leader>nts :exe ":NERDTree " . MY_SNIPPETS <CR>

" Open (n)erd (t)ree in my (n)otes folder
nnoremap <Leader>ntn :exe ":NERDTree " . MY_NOTES <CR>

" Open (n)erd (t)ree in folder where the (c)urrent file is.
nnoremap <Leader>ntc :exe ":NERDTree " . expand("%:p:h")<CR>

"}}}2

"}}}1
