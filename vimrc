syntax on
colorscheme molokai
set showmatch	" 対応括弧のハイライト
set display=uhex " 印字不可能文字を16進数表示
set cursorline
set nowrap											" 自動折り返し無効
set nobackup										" バックアップ無効
set autoread										" 書き換えられたら再読込
set noswapfile									" スワップファイル作らない
set hidden											" 編集中でも開ける
set backspace=indent,eol,start	" バックスペースで削除する文字
set formatoptions=lmoq					" テキスト整形オプション、マルチバイト系を追加
set vb t_vb=										" ビープ音無効
set ffs=unix,dos,mac  " 改行文字
set encoding=utf-8    " デフォルトエンコーディング
set fileformats=unix,dos,mac
" set autoindent	" 自動インデント
" set smartindent	" 改行後のインデント量を合わせる
" set cindent		" Cプログラムの自動インデント
set ignorecase	" 大文字小文字無視
set smartcase		" 検索文字列に大文字が含まれている場合は区別して検索
set incsearch		" インクリメンタルサーチ
set hlsearch		" 検索文字ハイライト
