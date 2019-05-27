" pwgen.vim
"   Author: Charles E. Campbell, Jr.
"   Date:   Dec 16, 2011
"   Version: 1a	ASTRO-ONLY
" ---------------------------------------------------------------------
"  Load Once: {{{1
if &cp || exists("g:loaded_PassWGen")
 finish
endif

let g:loaded_PassWGen = "v1z"
let s:keepcpo         = &cpo

set cpo&vim

" ---------------------------------------------------------------------
" PassWGen: {{{2
fun! PassWGen(len,symbols)
"  call Dfunc("PassWGen()")
  let symlen = strlen(a:symbols)
  let pw     = ""
  let i      = 0
  while i < a:len
   let pw = pw.(a:symbols[Dice(1,symlen)-1])
   let i  = i + 1
  endwhile

"  call Dret("PassWGen <".pw.">")
  return pw
endfun

" ---------------------------------------------------------------------
"  Restore: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo
" vim: ts=4 fdm=marker
