" TODO https://bitbucket.org/sergio/nvim-lua/src/main/lua/core/autocmd.lua

" colorize listchars
au VimEnter * hi! NonText guibg=NONE ctermbg=NONE guifg=#BFD4DB

" proper Jenkins syntax highlighting
au BufNewFile,BufRead Jenkinsfile setf groovy

" highlight yanked text, see https://neovim.io/doc/user/lua.html#lua-highlight
au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }

" realign buffers when terminal goes fullscreen
augroup FixProportionsOnResize
	au!
	au VimResized * exe "normal! \<c-w>="
augroup END

" spell checking for prose texts
augroup prose
  autocmd!
  autocmd FileType markdown set spell
  autocmd FileType text set spell
augroup end

" " LaTeX fast super/subscripts using UltiSnips' 'anonymous snippets'
" augroup latex
" 	au!
" 	autocmd FileType tex inoremap <silent> __ __<c-r>=UltiSnips#Anon('_{$1}$0', '__', '', 'i')<cr>
" 	autocmd FileType tex inoremap <silent> ^^ ^^<c-r>=UltiSnips#Anon('^{$1}$0', '^^', '', 'i')<cr>
" 	autocmd FileType tex inoremap <silent> $$ $$<C-R>=UltiSnips#Anon('\$ $1 \$ $0', '$$', '', 'i')<cr>
" augroup end
"
" " cleanup after closing vim
" augroup vimtex_config
" 	au!
"     " au User VimtexEventInitPost call vimtex#compiler#compile()
"     au User VimtexEventQuit call vimtex#compiler#clean(0)
" 	au User VimtexEventQuit call CloseVimTexViewers()
" augroup end
"
" function! CloseVimTexViewers()
" 	if executable('xdotool') && exists('b:vimtex')
" 	\ && exists('b:vimtex.viewer') && b:vimtex.viewer.xwin_id > 0
" 		call system('xdotool windowclose '. b:vimtex.viewer.xwin_id)
" 	endif
" endfunction
