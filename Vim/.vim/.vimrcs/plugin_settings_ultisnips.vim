" ------------------------------------------------------------
" General
" ------------------------------------------------------------

"Specifies the directories which are going to be searched by Vim when looking for snippets.
let g:UltiSnipsSnippetDirectories=["MySnippets"]

"By default, Vim sets ft=plaintex for empty .tex files, which can be changed with this
let g:tex_flavor="latex" 

" ------------------------------------------------------------
" Keybindings
" ------------------------------------------------------------

"Refresh known snippets at the local buffer. It is very useful when testing new snippets.
nnoremap <C-b> :call UltiSnips#RefreshSnippets()<CR>

