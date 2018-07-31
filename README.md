This is a micro-plugin for the [Vim](https://www.vim.org/) editor. It
simplifies searching for the current word or visually selected text in all
files in a directory. Search results are displayed in the location list.

With `grepprg` set to something other than `grep`, the plugin may not work
correctly.

The plugin doesn't define any mappings, you need to define these yourself,
e.g.:

	vnoremap <silent> <Leader>f :call find#FindVisualSelection()<CR>
	nnoremap <silent> <Leader>f :call find#FindWord()<CR>
