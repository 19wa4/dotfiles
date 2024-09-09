" set statusline=%{'-'->repeat(&columns)}
set statusline=%{my_statusline#last_search_count()}%f
set tabline=%!my_statusline#tabline()

augroup MyTerminal
  autocmd!
  autocmd BufEnter * redrawstatus
  autocmd BufEnter * redrawtabline
augroup END
