" Vimball Archiver by Charles E. Campbell
UseVimball
finish
autoload/AdvancedSorters/Expr.vim	[[[1
53
" AdvancedSorters/Expr.vim: Sorting by a custom expression.
"
" DEPENDENCIES:
"   - ingo/actions.vim autoload script
"   - ingo/err.vim autoload script
"
" Copyright: (C) 2014 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.00.003	10-Jun-2014	Implement unique sorting via additional
"				a:isUnique flag.
"	002	08-Jun-2014	Catch exceptions to avoid that the same
"				expression error is printed for all lines.
"				Silence the substitution messages.
"				Pass in the range instead of using
"				function-range to allow returning the success.
"				Undo the (first) substitution (assuming it
"				caused the exception) on failure. Else, the
"				entire range will be reduced to empty lines when
"				there's a problem with the passed expression.
"	001	08-Jun-2014	file creation

function! AdvancedSorters#Expr#Sort( startLnum, endLnum, isReverse, isUnique, expr )
    try
	if type(a:expr) == type(function('tr'))
	    silent execute a:startLnum . ',' . a:endLnum . 'substitute/^.*$/\= call(' . string(a:expr) . ',[submatch(0)]) . " " . submatch(0)/'
	else
	    silent execute a:startLnum . ',' . a:endLnum . 'substitute/^.*$/\=' . substitute(a:expr, '\C' . ingo#actions#GetValExpr(), 'submatch(0)', 'g') . ' . " " . submatch(0)/'
	endif
	execute a:startLnum . ',' . a:endLnum . 'sort' . (a:isReverse ? '!' : '') 'n'

	let l:lastLnum = line('$')  " When the a:isUnique flag is passed, duplicate lines reduce the number of lines.
	let l:sortOffset = 0        " Account for the reduced end line number when undoing the numbering.
	if a:isUnique
	    silent execute (a:startLnum + 1) . ',' . a:endLnum . 'g/^/if matchstr(getline(line(".") - 1), "^\\d\\+ ") ==# matchstr(getline("."), "^\\d\\+ ") | silent delete _ | endif'
	    let l:sortOffset = line('$') - l:lastLnum
	endif

	silent execute a:startLnum . ',' . (a:endLnum + l:sortOffset) . 'substitute/^\d\+ //'
	return 1
    catch /^Vim\%((\a\+)\)\=:/
	call ingo#err#SetVimException()
	silent! undo
	return 0
    finally
	call histdel('search', -1)
    endtry
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
autoload/AdvancedSorters/Ranges.vim	[[[1
209
" AdvancedSorters/Ranges.vim: Sorting of whole ranges as one unit.
"
" DEPENDENCIES:
"   - ingo/cmdargs/pattern.vim autoload script
"   - ingo/cmdargs/range.vim autoload script
"   - ingo/collections.vim autoload script
"   - ingo/compat.vim autoload script
"   - ingo/err.vim autoload script
"   - ingo/join.vim autoload script
"   - ingo/range.vim autoload script
"   - ingo/range/lines.vim autoload script
"
" Copyright: (C) 2014-2016 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.21.007	26-Oct-2016	BUG: :SortUnfolded and :SortRangedBy... remove
"				comment sigils (like "#") when 'formatoptions'
"				contains "j". Temporarily reset 'formatoptions'
"				to avoid interference of user settings. Thanks
"				to Holger Mitschke for reporting this!
"   1.20.006	03-Feb-2015	Refactoring: Remove optional argument of
"				s:GetSortArgumentsExpr().
"				Also support [/{pattern}/] [i][u][r][n][x][o]
"				:sort argument order (and mixed).
"   1.02.005	23-Sep-2014	BUG: :.SortRangesBy... doesn't work correctly on
"				a closed fold; need to use
"				ingo#range#NetStart().
"   1.01.004	11-Jun-2014	Make :SortRangesByRange work for Vim versions
"				before 7.4.218 that don't have uniq().
"   1.00.003	10-Jun-2014	Implement :SortRangesByRange command.
"				Pass a:ArgumentParser to s:JoinRanges() to
"				accommodate the different parsing for
"				:SortRangesByRange.
"	002	09-Jun-2014	Account for the reduced end line number when the
"				"u" flag is passed and there are duplicate lines.
"	001	08-Jun-2014	file creation from ingocommands.vim
let s:save_cpo = &cpo
set cpo&vim

function! s:SortRanges( bang, startLnum, endLnum, sortArgs, rangeName, rangeNum, joinCnt )
    if empty(a:rangeNum)
	call ingo#err#Set(printf('No %s found', a:rangeName))
	return 0
    endif

    let l:reducedEndLnum = a:endLnum - a:joinCnt
    let l:lastLnum = line('$')  " When the "u" flag is passed, duplicate lines reduce the number of lines.
    let l:sortOffset = 0        " Account for the reduced end line number when undoing the join.
    try
	execute printf('%d,%dsort%s %s', a:startLnum, l:reducedEndLnum, a:bang, a:sortArgs)
	let l:sortOffset = line('$') - l:lastLnum
	return 1
    catch /^Vim\%((\a\+)\)\=:/
	call ingo#err#SetVimException()
	return 0
    finally
	silent execute printf('%d,%dsubstitute/\%%d0/\r/ge', a:startLnum, l:reducedEndLnum + l:sortOffset)
	call histdel('search', -1)
    endtry
endfunction
function! AdvancedSorters#Ranges#Unfolded( bang, startLnum, endLnum, sortArgs )
    let [l:startLnum, l:endLnum] = [ingo#range#NetStart(a:startLnum), ingo#range#NetEnd(a:endLnum)]

    let l:save_formatoptions = &l:formatoptions
    setlocal formatoptions=
    try
	let [l:foldNum, l:joinCnt] = ingo#join#FoldedLines(1, l:startLnum, l:endLnum, "\<C-v>\<C-j>")
    finally
	let &l:formatoptions = l:save_formatoptions
    endtry

    return s:SortRanges(a:bang, l:startLnum, l:endLnum, a:sortArgs, 'folds', l:foldNum, l:joinCnt)
endfunction

let s:sortFlagsExpr = '[iurnxo[:space:]]'
function! s:GetSortArgumentsExpr( captureNum, flagsBeforePatternCardinality, ... )
    return '\s*\(' .
    \   s:sortFlagsExpr . a:flagsBeforePatternCardinality .
    \   '\%(\([[:alnum:]\\"|]\@![\x00-\xFF]\)\(.\{-}\)\%(\%(^\|[^\\]\)\%(\\\\\)*\\\)\@<!\' . a:captureNum . '\)\?' .
    \   s:sortFlagsExpr . '*' .
    \'\)'
endfunction
function! s:ParseExpressionAndSortArguments( arguments )
    return ingo#cmdargs#pattern#ParseUnescaped(a:arguments, s:GetSortArgumentsExpr(4, '*'))
endfunction
function! s:JoinRanges( bang, startLnum, endLnum, arguments, ArgumentParser, rangeName, RangeCreator )
    let [l:startLnum, l:endLnum] = [ingo#range#NetStart(a:startLnum), ingo#range#NetEnd(a:endLnum)]
    let [l:expr, l:sortArgs] = call(a:ArgumentParser, [a:arguments])

    let l:ranges = call(a:RangeCreator, [l:startLnum, l:endLnum, l:expr])

    let l:save_formatoptions = &l:formatoptions
    setlocal formatoptions=
    try
	let [l:rangeNum, l:joinCnt] = ingo#join#Ranges(1, l:startLnum, l:endLnum, "\<C-v>\<C-j>", l:ranges)
    finally
	let &l:formatoptions = l:save_formatoptions
    endtry

    return s:SortRanges(a:bang, l:startLnum, l:endLnum, l:sortArgs, a:rangeName, l:rangeNum, l:joinCnt)
endfunction



function! s:ByHeader( startLnum, endLnum, expr )
    let l:headerLnums = []
    call cursor(a:startLnum, 1)
    while line('.') <= a:endLnum
	let l:lnum = search(a:expr, 'cW', a:endLnum)
	if l:lnum == 0
	    break
	endif

	call add(l:headerLnums, l:lnum)

	if l:lnum == a:endLnum
	    break
	else
	    call cursor(l:lnum + 1, 1)
	endif
    endwhile

    let l:ranges = []
    for l:i in range(len(l:headerLnums))
	call add(l:ranges, [l:headerLnums[l:i], get(l:headerLnums,l:i + 1, a:endLnum + 1) - 1])
    endfor
    return l:ranges
endfunction
function! AdvancedSorters#Ranges#ByHeader( bang, startLnum, endLnum, arguments )
    return s:JoinRanges(a:bang, a:startLnum, a:endLnum, a:arguments, function('s:ParseExpressionAndSortArguments'), 'headers', function('s:ByHeader'))
endfunction

function! s:ByMatch( startLnum, endLnum, expr )
    let l:ranges = []
    call cursor(a:startLnum, 1)
    while line('.') <= a:endLnum
	let l:startLnum = search(a:expr, 'cW', a:endLnum)
	if l:startLnum == 0
	    break
	endif
	let l:endLnum = search(a:expr, 'ceW', a:endLnum)
	if l:endLnum == 0
	    break
	endif

	call add(l:ranges, [l:startLnum, l:endLnum])

	if l:endLnum == a:endLnum
	    break
	else
	    call cursor(l:endLnum + 1, 1)
	endif
    endwhile
    return l:ranges
endfunction
function! AdvancedSorters#Ranges#ByMatch( bang, startLnum, endLnum, arguments )
    return s:JoinRanges(a:bang, a:startLnum, a:endLnum, a:arguments, function('s:ParseExpressionAndSortArguments'), 'matches', function('s:ByMatch'))
endfunction

function! s:ParseRangeAndSortArguments( arguments )
    " Since both the range and the sort arguments can contain a /{pattern}/,
    " parsing is difficult. It's easier when there's a sort flag or whitespace
    " in between, so look for such first.
    let l:parsedRange = ingo#cmdargs#range#Parse(a:arguments, {'isParseFirstRange': 1, 'commandExpr': s:GetSortArgumentsExpr(5, '\+') . '$'})
    if empty(l:parsedRange)
	" Else, take the entire arguments as a range, with only optional sort
	" flags allowed (but no sort pattern). This means that here, there
	" *must* be a space or a sort flag between the /{pat1}/,/{pat2}/ range
	" and the /{pattern}/ sort argument.
	let l:parsedRange = ingo#cmdargs#range#Parse(a:arguments, {'isParseFirstRange': 1, 'commandExpr': '\s*\(' . s:sortFlagsExpr . '*\)$'})
    endif

    if empty(l:parsedRange)
	return ['', '']
    endif
    return l:parsedRange[3:4]
endfunction
function! s:ByRange( startLnum, endLnum, expr )
    if empty(a:expr) | return [] | endif

    " With ranges, there can be overlapping regions. To emulate a fold-like
    " behavior (where folds can be contained in others), go through the list of
    " unique line numbers and the list of lines where ranges end, and build the
    " [startLnum, endLnum] list out of that.
    let [l:recordedLines, l:startLines, l:endLines, l:didClobberSearchHistory] = ingo#range#lines#Get(a:startLnum, a:endLnum, a:expr)
    let l:linesInRange = sort(map(keys(l:recordedLines), 'str2nr(v:val)'), 'ingo#collections#numsort')
    call ingo#compat#uniq(l:endLines)
    let l:ranges = []
    while ! empty(l:endLines)
	let l:startLnum = remove(l:linesInRange, 0)
	let l:endLnum = remove(l:endLines, 0)
	if l:startLnum < l:endLnum
	    call add(l:ranges, [l:startLnum, l:endLnum])
	    call remove(l:linesInRange, 0, index(l:linesInRange, l:endLnum))
	endif
    endwhile

    return l:ranges
endfunction
function! AdvancedSorters#Ranges#ByRange( bang, startLnum, endLnum, arguments )
    return s:JoinRanges(a:bang, a:startLnum, a:endLnum, a:arguments, function('s:ParseRangeAndSortArguments'), 'ranges', function('s:ByRange'))
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
autoload/AdvancedSorters/Uniq.vim	[[[1
74
" AdvancedSorters/Uniq.vim: Keep unique lines.
"
" DEPENDENCIES:
"   - ingo/actions.vim autoload script
"   - ingo/cmdargs/pattern.vim autoload script
"   - ingo/collections.vim autoload script
"   - ingo/lines.vim autoload script
"   - ingo/range.vim autoload script
"
" Copyright: (C) 2015 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.20.001	03-Feb-2015	file creation

function! s:Parse( arguments )
    let l:uniqFlagsExpr = '[ir[:space:]]'
    let [l:flagsBeforePattern, l:restArguments] = matchlist(a:arguments, '^\(' . l:uniqFlagsExpr . '*\)\(.*\)$')[1:2]
    let [l:pattern, l:flagsAfterPattern] = ingo#cmdargs#pattern#ParseUnescaped(l:restArguments, '\(' . l:uniqFlagsExpr . '*\)')
    return [l:flagsBeforePattern . l:flagsAfterPattern, l:pattern]
endfunction
function! s:MakeUnique( lines, modificationExpr )
    if a:modificationExpr ==# 'v:val'
	return ingo#collections#UniqueStable(a:lines)
    endif

    let l:itemDict = {}
    let l:result = []
    let l:nonMatching = []
    for l:line in a:lines
	let l:key = (l:line ==# '' ? "\<Nul>" : ingo#actions#EvaluateWithVal(a:modificationExpr, l:line))
	if empty(l:key)
	    call add(l:result, l:line)
	elseif ! has_key(l:itemDict, l:key)
	    let l:itemDict[l:key] = 1
	    call add(l:result, l:line)
	endif
    endfor
    return l:result
endfunction
function! AdvancedSorters#Uniq#Uniq( startLnum, endLnum, arguments )
    let [l:startLnum, l:endLnum] = [ingo#range#NetStart(a:startLnum), ingo#range#NetEnd(a:endLnum)]

    let [l:flags, l:pattern] = ['', '']
    if ! empty(a:arguments)
	let [l:flags, l:pattern] = s:Parse(a:arguments)
	if l:pattern ==# a:arguments
	    " The parsing should have removed the /.../ delimiters; the argument
	    " either has none, or the argument syntax is wrong.
	    call ingo#err#Set('Invalid argument: ' . a:arguments)
	    return 0
	endif
    endif

    let l:modificationExpr = 'v:val'
    if ! empty(l:pattern)
	if l:flags =~# 'r'
	    let l:modificationExpr = printf("matchstr(v:val, %s)", string(l:pattern))
	else
	    let l:modificationExpr = printf("v:val =~# %s ? substitute(v:val, %s, '', 'g') : ''", string(l:pattern), string(l:pattern))
	endif
    endif
    if l:flags =~# 'i'
	let l:modificationExpr = 'tolower(' . l:modificationExpr . ')'
    endif

    let l:lines = s:MakeUnique(getline(l:startLnum, l:endLnum), l:modificationExpr)
    call ingo#lines#Replace(l:startLnum, l:endLnum, l:lines)
    return 1
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
autoload/AdvancedSorters/Words.vim	[[[1
45
" AdvancedSorters/Words.vim: Sort individual WORDs instead of full lines.
"
" DEPENDENCIES:
"
" Copyright: (C) 2014 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.10.001	06-Nov-2014	file creation

function! AdvancedSorters#Words#Sort( bang, startLnum, endLnum, arguments )
    " Join lines, delete indent and trailing whitespace.
    execute printf('silent %d,%dsubstitute/\s\+\|\s\+\n\s*\|\s*\n\s\+/\r/g', a:startLnum, a:endLnum)
    let [l:endLnum, l:lineNum] = [line("']"), line('$')]

    " Remove completely empty lines.
    execute printf('silent %d,%dglobal/^$/delete _', a:startLnum, l:endLnum)
    call histdel('search', -1)

    let l:deletedLineNum = l:lineNum - line('$')
    let l:endLnum -= l:deletedLineNum
    if l:endLnum < a:startLnum
	silent! undo
	call ingo#err#Set('No WORDs to sort')
	return 0
    endif

    try
	let l:lineNum = line('$')
	execute printf("silent %d,%dsort%s %s", a:startLnum, l:endLnum, a:bang, a:arguments)
	let l:duplicatedNum = l:lineNum - line('$')
	let l:endLnum -= l:duplicatedNum

	execute printf("silent %d,%djoin", a:startLnum, l:endLnum)
	return 1
    catch /^Vim\%((\a\+)\)\=:/
	silent! undo
	call ingo#err#SetVimException()
	return 0
    endtry
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
plugin/AdvancedSorters.vim	[[[1
74
" AdvancedSorters.vim: Sorting of certain areas or by special needs.
"
" DEPENDENCIES:
"   - AdvancedSorters/Expr.vim autoload script
"   - AdvancedSorters/Ranges.vim autoload script
"   - ingo/compat.vim autoload script
"   - ingo/err.vim autoload script
"
" Copyright: (C) 2014-2015 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.20.005	03-Feb-2015	Add :Uniq command.
"   1.10.004	06-Nov-2014	Add :SortWORDs command.
"   1.00.003	10-Jun-2014	Add :SortRangesByRange command.
"				Add :SortByExprUnique variant.
"	002	08-Jun-2014	Have :SortBy... commands check for buffer
"				modifiablity and handle errors, too.
"	001	08-Jun-2014	file creation

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_AdvancedSorters') || (v:version < 700)
    finish
endif
let g:loaded_AdvancedSorters = 1
let s:save_cpo = &cpo
set cpo&vim

command! -bang -range=% -nargs=* SortUnfolded
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Ranges#Unfolded('<bang>', <line1>, <line2>, <q-args>) | echoerr ingo#err#Get() | endif

command! -bang -range=% -nargs=+ SortRangesByHeader
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Ranges#ByHeader('<bang>', <line1>, <line2>, <q-args>) | echoerr ingo#err#Get() | endif

command! -bang -range=% -nargs=+ SortRangesByMatch
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Ranges#ByMatch('<bang>', <line1>, <line2>, <q-args>) | echoerr ingo#err#Get() | endif

command! -bang -range=% -nargs=+ SortRangesByRange
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Ranges#ByRange('<bang>', <line1>, <line2>, <q-args>) | echoerr ingo#err#Get() | endif


command! -bang -range=% -nargs=1 -complete=expression SortByExpr
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Expr#Sort(<line1>, <line2>, <bang>0, 0, <q-args>) | echoerr ingo#err#Get() | endif

command! -bang -range=% -nargs=1 -complete=expression SortByExprUnique
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Expr#Sort(<line1>, <line2>, <bang>0, 1, <q-args>) | echoerr ingo#err#Get() | endif

command! -bang -range=% SortByCharLength
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Expr#Sort(<line1>, <line2>, <bang>0, 0, function('ingo#compat#strchars')) | echoerr ingo#err#Get() | endif

command! -bang -range=% SortByWidth
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Expr#Sort(<line1>, <line2>, <bang>0, 0, function('ingo#compat#strdisplaywidth')) | echoerr ingo#err#Get() | endif

command! -bang -range -nargs=* SortWORDs
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Words#Sort('<bang>', <line1>, <line2>, <q-args>) | echoerr ingo#err#Get() | endif

command! -range=% -nargs=* Uniq
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Uniq#Uniq(<line1>, <line2>, <q-args>) | echoerr ingo#err#Get() | endif

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
doc/AdvancedSorters.txt	[[[1
205
*AdvancedSorters.txt*   Sorting of certain areas or by special needs.

		      ADVANCED SORTERS    by Ingo Karkat
							 *AdvancedSorters.vim*
description			|AdvancedSorters-description|
usage				|AdvancedSorters-usage|
installation			|AdvancedSorters-installation|
limitations			|AdvancedSorters-limitations|
known problems			|AdvancedSorters-known-problems|
todo				|AdvancedSorters-todo|
history				|AdvancedSorters-history|

==============================================================================
DESCRIPTION					 *AdvancedSorters-description*

The built-in |:sort| command is powerful, but it still is line-based. It
doesn't take into account folded lines, nor can it sort entire blocks like
function definitions, paragraphs, etc. But often, one needs to sort exactly
such areas as single entities, i.e. without changing the line order within
them. A workaround in Vim is condensing each block into a single line,
performing the sorting, and then expanding again. (External, more powerful
sort commands could be used, too.)

This plugin implements this workaround and encapsulates the three separate
steps in one handy command.


While |:sort| has several flags for sorting on various numbers, and a
/{pattern}/ can be specified to skip or sort on, it doesn't allow arbitrary
(Vimscript) expressions.

This plugin offers extension commands that evaluate an expression per line,
put that number in front of the line, do a numerical sort, and then remove the
temporary number again. Specializations handle the common sort by number of
characters and by the line's display width.

SOURCE									     *

- :SortUnfolded inspired by
  http://stackoverflow.com/questions/13554191/sorting-vim-folds
- :SortRangesByRange inspired by
  http://superuser.com/questions/752032/how-do-i-sort-multiple-blocks-of-text-by-the-first-line-in-each-block-in-vim
- :SortByExpr inspired by
  http://stackoverflow.com/questions/11531073/how-do-you-sort-a-range-of-lines-by-length
- :SortWORDs inspired by
  http://stackoverflow.com/questions/26739697/sort-line-horizontally-in-vim
  http://stackoverflow.com/questions/1327978/sorting-words-not-lines-in-vim

SEE ALSO								     *

- The |LineJuggler.vim| plugin (vimscript #4140) offers many quick mappings to
  move around (blocks of) lines. For small data sets, manual shifting may be
  quicker than coming up with a correct sort command.

==============================================================================
USAGE						       *AdvancedSorters-usage*
							       *:SortUnfolded*
:[range]SortUnfolded[!] [i][u][r][n][x][o] [/{pattern}/]
			Sort visible lines in the buffer / [range]. Lines
			inside closed folds are kept intact; sorting is done
			on all lines of the fold as one unit; i.e. the order
			of the other lines inside the fold does _not_ change!
							 *:SortRangesByHeader*
:[range]SortRangesByHeader[!] /{expr}/ [i][u][r][n][x][o] [/{pattern}/]
			Each match of {expr} (in the buffer / [range]) starts
			a new area that sorts as one unit; i.e. the order of
			the other lines inside the area does _not_ change!
							  *:SortRangesByMatch*
:[range]SortRangesByMatch[!] /{expr}/ [i][u][r][n][x][o] [/{pattern}/]
			Each (multi-line) match of {expr} (in the buffer /
			[range]) defines an area that sorts as one unit.
			Non-matching lines are sorted individually.
							  *:SortRangesByRange*
:[range]SortRangesByRange[!] {range} [i][u][r][n][x][o] [/{pattern}/]
			Each {range} (in the buffer / [range]) defines an area
			that sorts as one unit.
			Note: For this command, /{pattern}/ must be separated
			from the {range} by a [i][u][r][n][x][o] flag or a
			space; you cannot directly concatenate them.

			Note: The text must not contain embedded <Nul>
			characters (^@) for the above commands!

								 *:SortByExpr*
:[range]SortByExpr[!] {expr}
			Sort lines in [range] by the {expr}, which should take
			the current line as input via v:val and return a
			number. With [!] the order is reversed.
							   *:SortByExprUnique*
:[range]SortByExprUnique[!] {expr}
			Sort lines in [range] by the {expr}; only the first
			line that gets a certain number from {expr} is kept.
			With [!] the order is reversed.
							   *:SortByCharLength*
:[range]SortByCharLength[!]
			Sort lines in [range] by the number of characters.
								*:SortByWidth*
:[range]SortByWidth[!]
			Sort lines in [range] by the display width.

								  *:SortWORDs*
:[range]SortWORDs[!] [i][u][r][n][x][o] [/{pattern}/]
			Sort individual (whitespace-delimited) |WORDs| in the
			current line / [range].

								       *:Uniq*
:[range]Uniq[!] [i][r] [/{pattern}/]
			Remove lines in [range] that have already been
			encountered earlier (not necessarily adjacent).
			With [i] case is ignored.
			When /{pattern}/ is specified and there is no [r] flag
			the text matched with {pattern} is ignored.
			With [r] only the matching {pattern} is considered;
			the rest is ignored.
			If a {pattern} is used, any lines which don't have a
			match for {pattern} are kept.

EXAMPLE						     *AdvancedSorters-example*

We're taking any Vimscript file with multiple function definitions as an
example, and show how to sort whole functions according to function name (and
arguments).

To use folding, we first have to define the folds, then trigger the sorting: >
    :g/^function/,/^endfunction/fold
    :SortUnfolded

If we don't care about including any lines after the "endfunction", we can
just base the areas on the function start: >
    :SortRangesByHeader /^function/
But we'll get better results with an explicit end. One way is to define a
multi-line pattern that covers the entire function: >
    :SortRangesByMatch /^function\_.\{-}\nendfunction$/
Another way spans up a range, similar to what we've done above to define the
folds: >
    :SortRangesByRange /^function/,/^endfunction$/
<
==============================================================================
INSTALLATION					*AdvancedSorters-installation*

This script is packaged as a |vimball|. If you have the "gunzip" decompressor
in your PATH, simply edit the *.vmb.gz package in Vim; otherwise, decompress
the archive first, e.g. using WinZip. Inside Vim, install by sourcing the
vimball or via the |:UseVimball| command. >
    vim AdvancedSorters*.vmb.gz
    :so %
To uninstall, use the |:RmVimball| command.

DEPENDENCIES					*AdvancedSorters-dependencies*

- Requires Vim 7.0 or higher.
- Requires the |ingo-library.vim| plugin (vimscript #4433), version 1.022 or
  higher.

==============================================================================
LIMITATIONS					 *AdvancedSorters-limitations*

KNOWN PROBLEMS				      *AdvancedSorters-known-problems*

TODO							*AdvancedSorters-todo*

IDEAS						       *AdvancedSorters-ideas*

==============================================================================
HISTORY						     *AdvancedSorters-history*

1.21	26-Oct-2016
- BUG: :SortUnfolded and :SortRangedBy... remove comment sigils (like "#")
  when 'formatoptions' contains "j". Temporarily reset 'formatoptions' to
  avoid interference of user settings. Thanks to Holger Mitschke for reporting
  this!

1.20	09-Feb-2015
- Add :Uniq command.
- Also support [/{pattern}/] [i][u][r][n][x][o] :sort argument order (and
  mixed).
- FIX: Include missing Words.vim module that prevented the :SortWORDs command
  introduced in the previous version 1.10 from functioning.

1.10	23-Dec-2014
- Add :SortWORDs command.

1.02	06-Nov-2014
- BUG: :.SortRangesBy... doesn't work correctly on a closed fold; need to use
  ingo#range#NetStart().
  *** You need to update to ingo-library (vimscript #4433) version 1.022! ***

1.01	10-Jul-2014
- Make :SortRangesByRange work for Vim versions before 7.4.218 that don't have
  uniq().
  *** You need to update to ingo-library (vimscript #4433) version 1.021! ***

1.00	11-Jun-2014
First published version.

0.01	18-Jul-2012
Started development.

==============================================================================
Copyright: (C) 2012-2016 Ingo Karkat
The VIM LICENSE applies to this plugin; see |copyright|.

Maintainer:	Ingo Karkat <ingo@karkat.de>
==============================================================================
 vim:tw=78:ts=8:ft=help:norl:
