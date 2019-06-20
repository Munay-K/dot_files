" !1| --------------------------------------------------
" !1| General
" !1| --------------------------------------------------


" Always open NERDTree on the right side
let g:NERDTreeWinPos = "right"

" Disables the 'Bookmarks' label 'Press ? for helpἀ text.
let NERDTreeMinimalUI = 1

" !1| --------------------------------------------------
" !1| Keybindings
" !1| --------------------------------------------------


" !2| --------------------------------------------------
" !2| Default modifiers
" !2| --------------------------------------------------

" Faster file opening or most known as 'ranger' file opening.
" Use l to open directories and files in current buffer, the default value is 'o'.
let NERDTreeMapActivateNode = 'l'

" Tells the NERDTree whether to display hidden files on startup.
let NERDTreeShowHidden = 1

" !2| --------------------------------------------------
" !2| Non-default modifiers
" !2| --------------------------------------------------

" Run :NERDTree command
nnoremap <C-n> :NERDTree<CR>

" Open NERDTREE menu in my templates folder
nnoremap <Leader>nt :NERDTree $HOME/Documents/MyFiles/dc_GithubRepos/dot_files/.txt_files/templates/<CR>
" Open NERDTREE menu in my snippets folder
nnoremap <Leader>ns :NERDTree $HOME/.vim/MySnippets/<CR>
" Open NERDTREE menu in my notes folder
nnoremap <Leader>nn :NERDTree $HOME/Documents/MyFiles/dc_GithubRepos/dot_files/.txt_files/notes/<CR>
" Open NERDTree menu in my code examples folder
nnoremap <Leader>ne :NERDTree $HOME/Documents/MyFiles/dc_GithubRepos/dot_files/.txt_files/examples/<CR>

" Open NERDTree in the file from the current folder
nnoremap <Leader>nc :exe ":NERDTree " . expand("%:p:h")<CR>
