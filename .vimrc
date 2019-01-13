" ------------------------------------------------------------
" .vimrc
" ------------------------------------------------------------

" ------------------------------------------------------------
" Dein.vim settings
"

if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim/

call dein#begin('~/.vim/dein/')

" plugins
call dein#add('airblade/vim-gitgutter')
call dein#add('eagletmt/ghcmod-vim')
call dein#add('eagletmt/neco-ghc')
call dein#add('fatih/vim-go')
call dein#add('flazz/vim-colorschemes')
call dein#add('thinca/vim-quickrun')
call dein#add('itchyny/lightline.vim')
call dein#add('justmao945/vim-clang')
call dein#add('kannokanno/previm')
call dein#add('kien/ctrlp.vim')
call dein#add('neovimhaskell/haskell-vim')
call dein#add('osyo-manga/vim-over')
call dein#add('rhysd/wandbox-vim')
call dein#add('scrooloose/syntastic')
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler.vim')
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
call dein#add('Shougo/vimshell.vim')
call dein#add('tyru/open-browser.vim')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-surround')
call dein#add('vim-jp/vimdoc-ja')

call dein#end()

if dein#check_install()
	call dein#install()
endif

filetype plugin indent on


" ------------------------------------------------------------
" neocomplcache settings
"

let g:neocomplcache_enable_at_startup = 1


" ------------------------------------------------------------
" Plugin settings
"

let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'component': {
      \   'readonly': '%{&readonly? "x":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

augroup PrevimSettings
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END


" ------------------------------------------------------------
" Vim settings
"

set ambiwidth=double
set autoindent
set backup
set backspace=indent,eol,start
set backupdir=/tmp
set directory=/tmp
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set nocindent
set noexpandtab
set nohlsearch
set noshowmode
set number
set ruler
set secure
set showcmd
set showmatch
set smartcase
set swapfile
set tabstop=4
set title
set t_Co=256
set visualbell
set wrapscan

syntax enable

colorscheme molokai


" ------------------------------------------------------------
" Encoding ( http://www.kawaz.jp/pukiwiki/?cmd=read&page=vim&word=vim#cb691f26 )
"

set encoding=utf-8

if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif
