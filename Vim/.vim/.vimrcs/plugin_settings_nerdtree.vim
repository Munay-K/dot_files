" ------------------------------------------------------------
" _[1]_ General
" ------------------------------------------------------------

" Always open NERDTree on the right side
let g:NERDTreeWinPos = "right"

" Disables the 'Bookmarks' label 'Press ? for helpἀ text.
let NERDTreeMinimalUI = 1

" ------------------------------------------------------------
" _[1]_ Keybindings
" ------------------------------------------------------------

" ------------------------------------------------------------
" _[2]_ Default modifiers
" ------------------------------------------------------------

" Faster file opening or most known as 'ranger' file opening.
" Use l to open directories and files in current buffer, the default value is 'o'.
let NERDTreeMapActivateNode = 'l'

" ------------------------------------------------------------
" _[2]_ New
" ------------------------------------------------------------

" Run :NERDTree command
nnoremap <C-n> :NERDTree<CR>

" Open my templates folder
nnoremap <Leader>nt :NERDTree ~/.vim/templates/<CR>

" Open NERDTree in the file from the current folder
nnoremap <Leader>nc :exe ":NERDTree " . expand("%:p:h")<CR>
