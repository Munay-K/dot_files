" !1| --------------------------------------------------
" !1| General
" !1| --------------------------------------------------

"Specifies the directories which are going to be searched by Vim when looking for snippets.
let g:UltiSnipsSnippetDirectories=["MySnippets"]

" !1| --------------------------------------------------
" !1| Keybindings
" !1| --------------------------------------------------

"Refresh known snippets at the local buffer. It is very useful when testing new snippets.
nnoremap <C-b> :call UltiSnips#RefreshSnippets()<CR>

"Key used to trigger expanding a snippet and to select text for the ${VISUAL} placeholder.
let g:UltiSnipsExpandTrigger='<tab>'
