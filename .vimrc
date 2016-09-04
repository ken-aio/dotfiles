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
"NeoBundle 'marcus/rsense'
NeoBundle 'NigoroJr/rsense'
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
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/neomru.vim'

" rails
NeoBundle 'tpope/vim-rails'
NeoBundle 'basyura/unite-rails'

" Tree view
NeoBundle 'scrooloose/nerdtree'

" Golang
NeoBundle 'vim-jp/vim-go-extra'

" helpの日本語化
NeoBundle 'vim-jp/vimdoc-ja'

" ファイルのサーチ
NeoBundle "ctrlpvim/ctrlp.vim"

" vimでgitの差分見る
NeoBundle "airblade/vim-gitgutter"

call neobundle#end()

" プラグインがインストールされているかチェック
NeoBundleCheck

if !has('vim_starting')
  " .vimrcを読み込み直したときのための設定
  call neobundle#call_hook('on_source')
endif

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

" undoを保存する
set undofile

" 最低でも上下に表示する行数
set scrolloff=5

"ステータス行の表示内容を設定する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"前のコマンドと同じコマンドを実行する操作を[c.]に変更
nnoremap c. q:k<Cr>

" 閉じカッコの補完 http://qiita.com/shingargle/items/dd1b5510a0685837504a
inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>

" Leaderを,に割り当て
let mapleader = "@"
" ,のデフォルトの機能は、\で使えるように退避
noremap \  @

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
" vimdoc-jp help
" -------------------------------
set helplang=ja,en

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

""""""""""""""""""""""""""""""""""""""""""""""""""
""" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent><C-e> :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
""" Unite outline
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_split_rule = 'botright'
nnoremap <C-u> :Unite -vertical -no-quit -winwidth=40 outline<Esc>

""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-go
""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundleLazy 'fatih/vim-go', {
       \ 'autoload' : {
       \   'filetypes' : 'go',
       \   'commands' : ['GoInstallBinaries', 'GoUpdateBinaries'],
       \ }}

" vim-go "{{{
let bundle = neobundle#get('vim-go')
function! bundle.hooks.on_source(bundle)
       let g:go_fmt_autosave = 0
       let g:go_fmt_fail_silently = 1
endfunction
"}}}
" settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap <Leader>b <Plug>(go-build)
au FileType go nmap <Leader>t <Plug>(go-test)
au FileType go nmap <Leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)
" syntax highlight
autocmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd FileType go :match goErr /\<err\>/

""""""""""""""""""""""""""""""""""""""""""""""""""
""" CtrlP Prefix: z
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap z <Nop>
nnoremap za :<C-u>CtrlP<Space>
nnoremap zb :<C-u>CtrlPBuffer<CR>
nnoremap zd :<C-u>CtrlPDir<CR>
nnoremap zf :<C-u>CtrlP<CR>
nnoremap zl :<C-u>CtrlPLine<CR>
nnoremap zm :<C-u>CtrlPMRUFiles<CR>
nnoremap zq :<C-u>CtrlPQuickfix<CR>
nnoremap zs :<C-u>CtrlPMixed<CR>
nnoremap zt :<C-u>CtrlPTag<CR>

let g:ctrlp_map = '<Nop>'
" Guess vcs root dir
let g:ctrlp_working_path_mode = 'ra'
" Open new file in current window
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_extensions = ['tag', 'quickfix', 'dir', 'line', 'mixed']
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:18'

""""""""""""""""""""""""""""""""""""""""""""""""""
""" gitgutter Prefix: ,
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>
