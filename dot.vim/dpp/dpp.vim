scriptencoding utf-8

augroup MyDppAutocmd
  autocmd!
augroup END

let $CACHE = '~/.cache'->expand()
if !$CACHE->isdirectory()
  call mkdir($CACHE, 'p')
endif

function InitPlugin(plugin)
  " Search from ~/work directory
  let dir = '~/work/'->expand() .. a:plugin->fnamemodify(':t')
  if !dir->isdirectory()
    " Search from $CACHE directory
    let dir = $CACHE .. '/dpp/repos/github.com/' .. a:plugin
    if !dir->isdirectory()
      " Install plugin automatically.
      execute 'silent !git clone https://github.com/' .. a:plugin dir
    endif
  endif

  execute 'set runtimepath^='
    \ .. dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
endfunction

" NOTE: dpp.vim path must be added
call InitPlugin('Shougo/dpp-ext-lazy')
call InitPlugin('Shougo/dpp.vim')
call InitPlugin('vim-denops/denops.vim')


"---------------------------------------------------------------------------
" dpp configurations.
function InstallPlugin()
  " if dpp#sync_ext_action('installer', 'getNotInstalled')->len()
  call dpp#async_ext_action('installer', 'install')
  " endif
endfunction

function UpdatePlugin()
  " if dpp#sync_ext_action('installer', 'checkNotUpdated')
  call dpp#async_ext_action('installer', 'update')
  " endif
endfunction


" Set dpp base path (required)
const s:dpp_base = '~/.cache/dpp'->expand()
let $BASE_DIR = '<sfile>'->expand()->fnamemodify(':h')

if has('nvim')
  const s:profile = getenv('NVIM_APPNAME')
else
  const s:profile = 'vim'
endif

if dpp#min#load_state(s:dpp_base, s:profile)
  " NOTE: denops.vim and dpp plugins are must be added
  for s:plugin in [
      \   'Shougo/dpp-ext-installer',
      \   'Shougo/dpp-ext-local',
      \   'Shougo/dpp-ext-packspec',
      \   'Shougo/dpp-ext-toml',
      \   'Shougo/dpp-protocol-git',
      \   'vim-denops/denops.vim',
      \ ]
    call InitPlugin(s:plugin)
  endfor

  " NOTE: Manual load is needed for neovim
  " Because "--noplugin" is used to optimize.
  if has('nvim')
    runtime! plugin/denops.vim
  endif

  autocmd MyDppAutocmd User DenopsReady
    \ : echohl WarningMsg
    \ | echomsg 'dpp load_state() is failed'
    \ | echohl NONE
    \ | call dpp#make_state(s:dpp_base, '$BASE_DIR/dpp.ts'->expand(), s:profile)
else
  autocmd MyDppAutocmd BufWritePost *.lua,*.vim,*.toml,*.ts,vimrc,.vimrc
    \ call dpp#check_files()
endif

autocmd MyDppAutocmd User Dpp:makeStatePost
  \ : echohl WarningMsg
  \ | echomsg 'dpp make_state() is done'
  \ | echohl NONE
