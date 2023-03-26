scriptencoding utf-8

filetype off
filetype plugin indent off
syntax off

set runtimepath^=~/.vim
set runtimepath+=~/.vim/after
set packpath^=~/.vim
if filereadable(expand('~/.vim/vimrc'))
  execute 'source' expand('~/.vim/vimrc')
endif


" --------------------------------------
" Option
"
set laststatus=3
set pumblend=30


" --------------------------------------
" dein.vim
"
if filereadable(expand($XDG_CONFIG_HOME . '/' . $NVIM_APPNAME . '/rc/dein.vim'))
  execute 'source' expand($XDG_CONFIG_HOME . '/' . $NVIM_APPNAME . '/rc/dein.vim')
endif


" --------------------------------------
" End of setting
"
filetype plugin indent on
syntax enable
if !exists('g:colors_name')
  colorscheme habamax
endif
