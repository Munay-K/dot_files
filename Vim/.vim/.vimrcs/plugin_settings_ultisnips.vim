"General {{{

"Specifies the directories which are going to be searched by Vim when looking for snippets.
let g:UltiSnipsSnippetDirectories=["MySnippets"]

"}}}
"Keybindings {{{

"Refresh known snippets at the local buffer. It is very useful when testing new snippets.
"SF: (u)lti (s)nips (r)efresh (s)nippets
nnoremap <Leader>usrs :call UltiSnips#RefreshSnippets()<CR>

"List all existent snippets in the current filetype.
"SF: (u)lti (s)nips (l)ist (s)nippets
nnoremap <Leader>usls :call UltiSnips#ListSnippets()<CR>

"Key used to trigger expanding a snippet and to select text for the ${VISUAL} placeholder.
let g:UltiSnipsExpandTrigger='<tab>'

"}}}
