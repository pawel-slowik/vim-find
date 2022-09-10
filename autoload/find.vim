function! find#FindVisualSelection() abort
	let saved_register = @s
	silent! normal! gv"sy
	let currSelection = find#FindClearNewline(@s)
	let @s = saved_register
	if empty(currSelection)
		call find#FindWarning('no current selection')
		return
	endif
	call find#Find(currSelection)
endfunction

function! find#FindWord() abort
	let currWord = expand('<cword>')
	if empty(currWord)
		call find#FindWarning('no current word')
		return
	endif
	call find#Find(currWord)
endfunction

function! find#Find(pattern) abort
	let pattern = escape(a:pattern, '%#') " see :help cmdline-special
	let pattern = shellescape(pattern)
	try
		let grepCommand = 'grep! -F ' . pattern . ' .'
		silent execute grepCommand
	catch
		call find#FindWarning('grep failed')
		return
	endtry
	let res_list = getqflist()
	if empty(res_list)
		call find#FindWarning("no matches for '" . a:pattern . "'")
		return
	endif
	copen
	redraw!
endfunction

function! find#FindClearNewline(s) abort
	if empty(a:s)
		return a:s
	endif
	let lastchar = strlen(a:s) - 1
	if char2nr(a:s[lastchar]) != 10
		return a:s
	endif
	return strpart(a:s, 0, lastchar)
endfunction

function! find#FindWarning(message) abort
	echohl WarningMsg
	echomsg 'Warning: ' . a:message
	echohl None
endfunction
