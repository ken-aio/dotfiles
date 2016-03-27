scriptencoding utf-8

set nocompatible
filetype plugin indent off

" ----- pluginのインストール -----
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
" Let NeoBundle manage NeoBundle
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

" コード補完
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'marcus/rsense'
NeoBundle 'supermomonga/neocomplete-rsense.vim'

" 静的解析
NeoBundle 'scrooloose/syntastic'

" ドキュメント参照
NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'

" メソッド定義元へのジャンプ
NeoBundle 'szw/vim-tags'

" 自動で閉じる
NeoBundle 'tpope/vim-endwise'

" unite
NeoBundle 'Shougo/unite.vim'

" rails
NeoBundle 'tpope/vim-rails'
NeoBundle 'basyura/unite-rails'



call neobundle#end()

"-----------------------------------------
" 基本設定
"-----------------------------------------
set encoding=utf-8
"(no)VimをなるべくVi互換にする
set nocompatible

"バックスペースキーの動作を決定する
"2:indent,eol,startと同じ
set backspace=2

"行番号を表示する
set number

"新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする
set autoindent

"検索で小文字なら大文字を無視、大文字なら無視しない設定
set smartcase

"(no)検索をファイルの末尾まで検索したら、ファイルの先頭へループする
set nowrapscan

"インクリメンタルサーチを行う
set incsearch

"highlight matches with last search pattern
set hlsearch

"(no)ウィンドウの幅を超える行の折り返し設定
set nowrap

"タブ文字、行末など不可視文字を表示する
set list

"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch

"カーソルが何行目の何列目に置かれているかを表示する
set ruler

"新しい行を作ったときに高度な自動インデントを行う
set smartindent

"保存しないで他のファイルを表示することが出来るようにする
set hidden

"カレントバッファ内のファイルの文字エンコーディングを設定する
"set fileencoding=utf-8
set fileencodings=utf-8,sjis,euc-jp,latin1

"Insertモードで<Tab> を挿入するのに、適切な数の空白を使う
set expandtab

"ファイル内の <Tab> が対応する空白の数
set tabstop=2

"自動インデントの各段階に使われる空白の数
set shiftwidth=2

"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
set smarttab

"(no)ファイルを上書きする前にバックアップファイルを作る
set nobackup

"強調表示(色付け)のON/OFF設定
syntax on

"listで表示される文字のフォーマットを指定する
"※デフォルト eol=$ を打ち消す意味で設定
set listchars=tab:>-

"カーソルの上または下に表示する最小限の行数
set scrolloff=5

"ステータスラインを表示するウィンドウを設定する
"2:常にステータスラインを表示する
set laststatus=2

"ステータス行の表示内容を設定する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"前のコマンドと同じコマンドを実行する操作を[c.]に変更
nnoremap c. q:k<Cr>

filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

"行末の空白文字を可視化
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

"全角スペースをハイライトさせる。
function! JISX0208SpaceHilight()
    syntax match JISX0208Space "　" display containedin=ALL
    highlight JISX0208Space term=underline ctermbg=LightCyan
endf

" vimにcoffeeファイルタイプを認識させる
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
" インデントを設定
autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et

" -------------------------------
" Rsense
" -------------------------------
let g:rsenseHome = '/usr/local/lib/rsense-0.3'
let g:rsenseUseOmniFunc = 1

" --------------------------------
" neocomplete.vim
" --------------------------------
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'
" 補完をキャンセルしpopupを閉じる
inoremap <expr><C-e> neocomplete#cancel_popup()
" TABで補完できるようにする
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

"-----------------------------------------
"Vim Rubocop
"-----------------------------------------
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']
" let g:syntastic_quiet_messages = {'level': 'warnings'}

""""""""""""""""""""""""""""""""""""""""""""""""""
""" neosnippet
""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"\ "\<Plug>(neosnippet_expand_or_jump)"
"\: pumvisible() ? "\<C-n>" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"\ "\<Plug>(neosnippet_expand_or_jump)"
"\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/dotfiles/snippets'

""""""""""""""""""""""""""""""""""""""""""""""""""
""" rails.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd User Rails Rnavcommand fabricator spec/fabricators -suffix=_fabricator.rb -default=controller()

""""""""""""""""""""""""""""""""""""""""""""""""""
""" unite.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
" 入力モードで開始する
let g:unite_enable_start_insert = 1

" 分割しないでuniteのbufferを表示する
nnoremap <Leader>u  :<C-u>Unite -no-split<Space>

" 全部乗せ
nnoremap <silent> <Leader>a  :<C-u>UniteWithCurrentDir -no-split -buffer-name=files buffer file_mru bookmark file<CR>
" ファイル一覧
nnoremap <silent> <Leader>f  :<C-u>Unite -no-split -buffer-name=files file<CR>
" バッファ一覧
nnoremap <silent> <Leader>j  :<C-u>Unite -no-split buffer<CR>
" 常用セット
nnoremap <silent> <Leader>u  :<C-u>Unite -no-split buffer file_mru<CR>
" 最近使用したファイル一覧
nnoremap <silent> <Leader>m  :<C-u>Unite -no-split file_mru<CR>
" 現在のバッファのカレントディレクトリからファイル一覧
nnoremap <silent> <Leader>d  :<C-u>UniteWithBufferDir -no-split file<CR>

" Ctrl + JはESCとする
au FileType unite inoremap <silent> <buffer> <C-j> <ESC>

" ESCキーで終了する
au FileType unite nmap <silent> <buffer> <C-j> <Plug>(unite_exit)
au FileType unite nmap <silent> <buffer> <ESC> <Plug>(unite_exit)

" Uniteに入る際はpasteモードをOFFにする
au FileType unite set nopaste
