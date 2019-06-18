" !1| General !1|

" Always open NERDTree on the right side
let g:NERDTreeWinPos = "right"

" Disables the 'Bookmarks' label 'Press ? for helpἀ text.
let NERDTreeMinimalUI = 1

" !1| Keybindings !1|

" !2| Default modifiers !2|

" Faster file opening or most known as 'ranger' file opening.
" Use l to open directories and files in current buffer, the default value is 'o'.
let NERDTreeMapActivateNode = 'l'

" Tells the NERDTree whether to display hidden files on startup.
let NERDTreeShowHidden = 1

" !2| Non-default modifiers !2|

" Run :NERDTree command
nnoremap <C-n> :NERDTree<CR>

" Open my templates folder
nnoremap <Leader>nt :NERDTree ~/.vim/templates/<CR>
" Open my snippets folder
nnoremap <Leader>ns :NERDTree ~/.vim/MySnippets/<CR>
" Open my snippets folder
nnoremap <Leader>nn :NERDTree ~/Documents/MyFiles/dc_GithubRepos/dot_files/.notes/<CR>

" Open NERDTree in the file from the current folder
nnoremap <Leader>nc :exe ":NERDTree " . expand("%:p:h")<CR>
