set encoding=utf-8
scriptencoding utf-8

" encofing系
"文字コードをUFT-8に設定
set fileencoding=utf-8
set fileformats=unix,dos,mac
set ambiwidth=double

" setting
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd

syntax on
" 良かったもの
colorscheme twilight


" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline


" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk


" Tab系
" 不可視文字を可視化(タブが「?-」と表示される)
"set list listchars=tab:\?\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

set whichwrap=b,s,h,l,<,>,[,],~

" コマンド補完
set wildmenu
set history=5000

" mouse enable
if has('mouse')
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  elseif v:version >703 || v:version is 703 && has('patch632')
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif

" paste settings
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBigin(ret)
    set paste
    return a:ret
  endfunction
  inoremap <special> <expr> <Esc>[200~ XTermPasteBigin("")
endif

" NeoBundle Settings--------------------------
if &compatible
  set nocompatible
endif
set runtimepath^=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'
" install package ---
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'tacahiroy/ctrlp-funky'
NeoBundle 'suy/vim-ctrlp-commandline'
NeoBundle 'junegunn/fzf.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'machakann/vim-sandwich'
NeoBundle 'w0rp/ale'
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tyru/caw.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'Yggdroot/indentLine'
"End install package ---
call neobundle#end()
filetype plugin indent on

NeoBundleCheck
"End NeoBundle Settings-----------------------

" ctags setting------------------
" https://qiita.com/aratana_tamoutomo/items/59fb4c377863a385e032
set tags=.tags;$HOME
set fileformats=unix,dos,mac
set fileencodings=utf-8,sjis
function! s:execute_ctags() abort
  let tag_name = '.tags'
  let tags_path = findfile(tag_name, '.;')
  if tags_path ==# ''
    return
  endif
  let tags_dirpath = fnamemodify(tags_path, ':p:h')
  execute 'silent !cd' tags_dirpath '&& ctags -R -f' tag_name '2> /dev/null &'
endfunction
augroup ctags
  autocmd!
  autocmd BufWritePost * call s:execute_ctags()
augroup END
"End ctags setting------------------

" CtrlP Settings
let g:ctrlp_match_window = 'order:ttb,min:20,max:20,results:100'
let g:ctrlp_show_hidden = 1 " .から始まるファイルも検索対象
let g:ctrlp_types = ['fil'] "ファイル検索のみ使用
let g:ctrlp_extensions = ['funky', 'commandline'] " 拡張として2つのプラグインを指定
" CtrlPCommandLineの有効化
command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id())
" CtrlPFunkyの有効化
let g:ctrlp_funky_matchtype = 'type'

" NERDTree Settings
"let g:NERDTreeShowBookmarks=1 " ブックマークを初期表示
"autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
map <C-l> gt
map <C-h> gT
