"
" Vim8用サンプル vimrc
"
if has('win32')                   " Windows 32bit または 64bit ?
  set encoding=cp932              " cp932 が嫌なら utf-8 にしてください
else
  set encoding=utf-8
endif
scriptencoding utf-8              " This file's encoding

" 推奨設定の読み込み (:h defaults.vim)
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

"古い自動コマンドを全てクリア
augroup MyVimrc
	autocmd!
augroup END

"===============================================================================
"vim-plugの設定を記述　vim-plugはプラグインマネージャです。
" vim-plugの設定開始（beginの引数はVimプラグインが格納されるディレクトリ）
call plug#begin('~/.vim/plugged')
"下記にインストールしたいVimプラグインを記述
" NERDTreeのインストール
Plug 'scrooloose/nerdtree'
Plug 'tomtom/tcomment_vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'altercation/vim-colors-solarized'
Plug 'mattn/emmet-vim'
Plug 'andymass/vim-matchup'
" SnipMateのインストール
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

" vim-plugの設定終了
call plug#end()
"===============================================================================
"===============================================================================
"vim本体に同梱化されているプラグインを追加する設定
"matchit  ※vim-matchupを導入したため停止
"vim標準の「%」機能を拡張する。if-endif間のジャンプ機能
"packadd matchit
"===============================================================================
" 設定の追加はこの行以降でおこなうこと！
" 分からないオプション名は先頭に ' を付けてhelpしましょう。例:
" :h 'helplang

"日本語helpの設定
"事前にシェルで以下のコマンドを実行してください。
"初回時：
" $git clone --depth=1 https://github.com/vim-jp/vimdoc-ja.git  ~/.vim/pack/my/opt/vimdoc-ja
"更新時：
" $cd ~/.vim/pack/my/opt/vimdoc-ja
" $git pull

packadd! vimdoc-ja                " 日本語help の読み込み
set helplang=ja,en                " help言語の設定

set number                        "行番号を表示
fixdel                            "delキーの値を補正
set autoindent
set smartindent
set list listchars=tab:>-,trail:_         "タブを「>-」で表示、行末の連続する空白文字を「_」で表示
set hlsearch                      "ハイライト有効
set incsearch                     "パターン入力中に次のマッチするテキストをハイライト
"ECSを２回押すことで検索ハイライトを消去
nnoremap <ESC><ESC> :nohlsearch<CR>
"対応カッコをハイライトを3秒表示
set showmatch
set matchtime=3

"set scrolloff=0
set scrolloff=3                   " 3行の余裕を持ってスクロールする
set laststatus=2                  " 常にステータス行を表示する
set cmdheight=2                   " hit-enter回数を減らすのが目的
if !has('gui_running')            " gvimではない？ (== 端末)
  set mouse=                      " マウス無効 (macOS時は不便かも？)
  set ttimeoutlen=0               " モード変更時の表示更新を最速化
  if $COLORTERM == "truecolor"    " True Color対応端末？
    set termguicolors
  endif
endif
set nofixendofline                " Windowsのエディタの人達に嫌われない設定
set ambiwidth=double              " ○, △, □等の文字幅をASCII文字の倍にする
set noswapfile                    "swapファイルを出力しない
"↓swapファイルを作成するディレクトリを指定する。
"set directory-=.                  " 指定値から「.」を除く。DefaltはHelp参照
set formatoptions+=mM             " 日本語の途中でも折り返す
let &grepprg="grep -rnIH --exclude=.git --exclude-dir=.hg --exclude-dir=.svn --exclude=tags"
"let loaded_matchparen = 1         " カーソルが括弧上にあっても括弧ペアをハイライトさせない

" :grep 等でquickfixウィンドウを開く (:lgrep 等でlocationlistウィンドウを開く)
"augroup qf_win
"  autocmd!
"  autocmd QuickfixCmdPost [^l]* copen
"  autocmd QuickfixCmdPost l* lopen
"augroup END

" マウスの中央ボタンクリックによるクリップボードペースト動作を抑制する
noremap <MiddleMouse> <Nop>
noremap! <MiddleMouse> <Nop>
noremap <2-MiddleMouse> <Nop>
noremap! <2-MiddleMouse> <Nop>
noremap <3-MiddleMouse> <Nop>
noremap! <3-MiddleMouse> <Nop>
noremap <4-MiddleMouse> <Nop>
noremap! <4-MiddleMouse> <Nop>

"-------------------------------------------------------------------------------
" ステータスライン設定
let &statusline = "%<%f %m%r%h%w[%{&ff}][%{(&fenc!=''?&fenc:&enc).(&bomb?':bom':'')}] "
if has('iconv')
  let &statusline .= "0x%{FencB()}"

  function! FencB()
    let c = matchstr(getline('.'), '.', col('.') - 1)
    if c != ''
      let c = iconv(c, &enc, &fenc)
      return s:Byte2hex(s:Str2byte(c))
    else
      return '0'
    endif
  endfunction
  function! s:Str2byte(str)
    return map(range(len(a:str)), 'char2nr(a:str[v:val])')
  endfunction
  function! s:Byte2hex(bytes)
    return join(map(copy(a:bytes), 'printf("%02X", v:val)'), '')
  endfunction
else
  let &statusline .= "0x%B"
endif
let &statusline .= "%=%l,%c%V %P"
"
"-------------------------------------------------------------------------------
" " ファイルエンコーディング検出設定
let &fileencoding = &encoding
if has('iconv')
  if &encoding ==# 'utf-8'
    let &fileencodings = 'iso-2022-jp,euc-jp,cp932,' . &fileencodings
  else
    let &fileencodings .= ',iso-2022-jp,utf-8,ucs-2le,ucs-2,euc-jp'
  endif
endif
" 日本語を含まないファイルのエンコーディングは encoding と同じにする
if has('autocmd')
  function! AU_ReSetting_Fenc()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding = &encoding
    endif
  endfunction
  augroup MyVimrc
    autocmd BufReadPost * call AU_ReSetting_Fenc()
  augroup END
endif

"-------------------------------------------------------------------------------
" カラースキームの設定
autocmd colorScheme * highlight StatusLine ctermfg=34
" ↓vim-colors-solarizedのプラグインを使用する場合はコメントアウトすること
 colorscheme torte

"try
"  silent hi CursorIM
"catch /E411/
  " CursorIM (IME ON中のカーソル色)が定義されていなければ、紫に設定
"  hi CursorIM ctermfg=16 ctermbg=127 guifg=#000000 guibg=#af00af
"endtry

" vim:set et ts=2 sw=0:
"-------------------------------------------------------------------------------
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" 以下導入したプラグインの設定を記述
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" [NERDTree]
" カレントディレクトリのファイルの一覧を表示する
" vim起動時に何も開かれていないときは、自動で起動
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> : NERDTreeToggle<CR>

"-------------------------------------------------------------------------------------
"TeraTerm経由だと見づらいため、停止中
"[vim-colors-solarized]
" set background=dark
"↓必要に応じて設定
" let g:solarized_termcolors=256
" colorscheme solarized
" ------------------------------------------------------------------------------------
"-------------------------------------------------------------------------------------
"警告「The legacy SnipMate parser is deprecated」に対する対応
"https://github.com/amix/vimrc/issues/635
"https://vi.stackexchange.com/questions/40034/how-to-fix-the-legacy-snipmate-parser-is-deprecated
"-------------------------------------------------------------------------------------
let g:snipMate={'snippet_version':1}
