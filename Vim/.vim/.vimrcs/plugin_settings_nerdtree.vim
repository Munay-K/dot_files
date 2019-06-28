" General {{{1

" Always open NERDTree on the right side
let g:NERDTreeWinPos = "right"

" Disables the 'Bookmarks' label 'Press ? for helpἀ text.
let NERDTreeMinimalUI = 1

"}}}1

"Keybindings {{{1

"Default {{{2

" Faster file opening or most known as 'ranger' file opening.
" Use l to open directories and files in current buffer, the default value is 'o'.
let NERDTreeMapActivateNode = 'l'

" Tells the NERDTree whether to display hidden files on startup.
let NERDTreeShowHidden = 1

"}}}2

"Custom {{{2

"Open the NERDTree menu.
nnoremap <C-n> :NERDTree<CR>

" Open my templates folder on the folder for a given filetype (If the file
" doesn't exist, then )
nnoremap <Leader>nt :exe ":NERDTree " . MY_TEMPLATES . &filetype<CR>
" Snippets folder
nnoremap <Leader>ns :exe ":NERDTree " . MY_SNIPPETS <CR>
" Notes folder
nnoremap <Leader>nn :exe ":NERDTree " . MY_NOTES <CR>

" Open NERDTree in the file from the current folder
nnoremap <Leader>nc :exe ":NERDTree " . expand("%:p:h")<CR>

"}}}2

"}}}1


