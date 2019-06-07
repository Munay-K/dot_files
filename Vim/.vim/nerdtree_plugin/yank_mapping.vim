call NERDTreeAddKeyMap({
        \ 'key': 'y',
        \ 'callback': 'NERDTreeYankCurrentNode',
        \ 'quickhelpText': 'put full path of current node into the default register' })

call NERDTreeAddKeyMap({
        \ 'key': 'yr',
        \ 'callback': 'NERDTreeYankRelativeLocationCurrentNode',
        \ 'quickhelpText': 'pull relative path of current nodee into the default register' })

" rf -> 'read file from current buffer'
call NERDTreeAddKeyMap({
        \ 'key': 'rf',
        \ 'callback': 'NERDTreeReadFile',
        \ 'quickhelpText': 'Read file into current buffer' })

function! NERDTreeYankCurrentNode()
    let n = g:NERDTreeFileNode.GetSelected()
    if n != {}
        call setreg('"', n.path.str())
    endif
endfunction

function! NERDTreeYankRelativeLocationCurrentNode()
    let n = g:NERDTreeFileNode.GetSelected()
    if n != {}
		call setreg('"', fnamemodify(n.path.str(), ':.'))
    endif
endfunction

function! NERDTreeReadFile()
    let n = g:NERDTreeFileNode.GetSelected()
	let @" = join(readfile(n.path.str()), "\n")
endfunction
