"Vimrc -- Author Evan LeCompte
" Set nocompatible first
set nocompatible

"enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" command mode
set wildmenu
set wildmode=list:longest,full
set wildignore+=*.jpg,*.png,*.gif,*.swf,*.bin,.tmp,.git,.svn,images/**,.class
set wildignorecase

" Always show current position
set ruler

" dont redraw while executing macros
"set nolazyredraw

" improves performance -- let OS decide when to flush disk
set nofsync

"no backup/swap
set nowb
set nobackup
set noswapfile

" lots of undolevels
set undolevels=500

" write buffer when leaving
set autowrite

" vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let vundle manage vundle
Bundle 'gmarik/vundle'

" Bundles
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/snipmate-snippets'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-pastie'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-abolish'
Bundle 'L9'
Bundle 'ScrollColors'
Bundle 'vim-scripts/mru.vim'
Bundle 'vim-scripts/vimwiki'
Bundle 'timcharper/textile.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'godlygeek/tabular'
Bundle 'vim-scripts/rest.vim'
Bundle 'vim-scripts/indentpython.vim'
Bundle 'python.vim--Vasiliev'
Bundle 'kien/ctrlp.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'csv.vim'
Bundle 'Vimpy'
Bundle 'less.vim'
Bundle 'digitaltoad/vim-jade'
Bundle 'mattsa/vim-eddie'
Bundle 'taglist.vim'
Bundle 'Lokaltog/vim-powerline'

set nowrap
set wrapmargin=5
" searches wrap around end of file
set wrapscan
set linebreak
set showbreak=>\
set startofline
" kinda crazy but I like it, allows cursor to move anywhere
set virtualedit=all
" use regex for search
set magic

set history=1000

set autowriteall

set mouse=a
set ttymouse=xterm2
set shell=/bin/bash

set ttimeoutlen=100

set fileencodings=ucs-bom,utf-8,windows-1252,default
set fileformats=unix,dos
set encoding=utf-8
set termencoding=utf-8

" Instantly leave insert mode when pressing <Esc>
" This works by disabling the mapping timeout completely in normal mode,
" and enabling it in insert mode with a very low timeout length.
augroup fastescape
  autocmd!

  set notimeout
  set ttimeout
  set timeoutlen=10

  au InsertEnter * set timeout
  au InsertLeave * set notimeout
augroup END

set iskeyword+=_,$,@,%,# " word dividers
set iskeyword-=/
set listchars=tab:>-,trail:-
"hide buffers when not displayed
set hidden

set vb t_vb= " disable any beeps or flashes on error
set autochdir

"maybe these speed things up?
set ttyfast
"set ttyscroll=1
let loaded_matchparen = 1

set viminfo='20,<50,s10,h,%
"new persistent undo feature (vim 7.3)
set undofile
set undodir=~/.vim/undo

" extended % matching
runtime macros/matchit.vim

" search
set nohls
set incsearch
set ignorecase
set smartcase

" show matching braces/brackets
set showmatch

"store .swp files in central location
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" intuitive backspacing in insert mode
set backspace=indent,eol,start


" identing
set tabstop=8
set shiftwidth=2
set softtabstop=2
set copyindent
set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
set expandtab
set smarttab


" copy / pasting
set clipboard=unnamed
set clipboard+=unnamed

" {{{ -[ Look ]-
" general
syntax on
set showcmd
set showmode
set number
set numberwidth=3
set foldmethod=marker
set nocursorline
set foldcolumn=3
set background=dark
set cmdheight=2
" show report when N lines were changed. 0 means always report
set report=0

" colors

if &term == "xterm"
  set t_Co=256
elseif &term == "linux"
  set t_Co=16
endif

if &diff
  color inkpot
else
  color molokai
endif

" }}}


"scroll off settings
set scrolloff=5
set sidescrolloff=7
set sidescroll=1

set shortmess=atI " shorten message prompts a bit
set mousehide "hide mouse when typing

"{{{ statusline setup
set statusline=%{getcwd()}\ %-10F

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%(\ %{fugitive#statusline()}%)

set statusline+=%= "left/right separator
set statusline+=%c, "cursor column
set statusline+=%l/%L "cursor line/total lines
set statusline+=\ %P "percent through file
set laststatus=2
"}}}

" Stop auto-commenting
au FileType * set comments=


"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction


"{{{ -[ FileTypes ]-

"json
autocmd BufRead,BufNewFile *.json setfiletype json

" text
autocmd FileType text setlocal textwidth=80

" mail
autocmd BufRead,BufNewFile *.mail setfiletype mail

autocmd FileType mail,human set formatoptions=tcq textwidth=72 comments+=b:--
" formatoptions=tcrqan -- annoying because you cant break line when you feel like it

" html
autocmd BufNewFile *.html  0r ~/.vim/skeleton.html

" PHP
let php_baselib = 1
let php_folding = 0
let php_sql_query = 1
let php_html_in_strings = 1
let php_no_shorttags = 0
let php_sync_method = 1
autocmd FileType php set noet shiftwidth=4 softtabstop=4 tabstop=4
autocmd FileType php set ft=php.html.javascript

" C
autocmd FileType c set expandtab ai shiftwidth=4 softtabstop=4 tabstop=4

" Python
autocmd FileType python let python_highlight_all = 1
autocmd FileType python set expandtab ai shiftwidth=4 softtabstop=4 tabstop=4

" LaTeX
autocmd Filetype tex,latex set grepprg=grep\ -nH\ $
autocmd Filetype tex,latex let g:tex_flavor = "latex"

" .Dat (binary, data files)
autocmd BufRead,BufNewFile *.dat set binary noendofline

" .less
autocmd BufRead,BufNewFile *.less set filetype=less

" jade
autocmd BufRead,BufNewFile *.jade set filetype=jade

" Java
autocmd BufRead,BufNewFile *.java set et ai filetype=java sw=4 sts=4


"}}}

"{{{ -[ Mappings ]-"


"make Y consistent with C and D
nnoremap Y y$

" Wincmd shortcuts
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

" taglist
nnoremap <silent> <F8> :TlistToggle<CR>
inoremap <silent> <F8> <esc>:TlistToggle<CR>
nnoremap <silent> <F9> :TlistUpdate<CR>
nnoremap <silent> <F9> :TlistUpdate<CR>

" Nerdtree
nnoremap <silent> <F4> :NERDTreeToggle<CR>
inoremap <silent> <F4> <esc>:NERDTreeToggle<CR>

" :wq shortcuts
nnoremap <silent> <F5> :w<CR>
inoremap <silent> <F5> <esc>:w<CR>
nnoremap <silent> <F6> :wq<CR>
inoremap <silent> <F6> <esc>:wq<CR>
nnoremap <silent> <F7> :wqa<CR>
inoremap <silent> <F7> <esc>:wqa<CR>

" Most Recently Used Files (MRU)
nnoremap <silent> <F12> :MRU<CR>
inoremap <silent> <F12> <esc>:MRU<CR>

" FuzzyFinder
nnoremap <silent> <F3> :CtrlP<CR>
inoremap <silent> <F3> <esc>:CtrlP<CR>

" Scroll a bit faster with <C-e> and <C-y>
nnoremap <C-e> 6<C-e>
nnoremap <C-y> 6<C-y>

map <leader>e :e! ~/.vim/vimrc<cr>

" Remove buffer
nnoremap <silent> <LocalLeader>- :bd<CR>

" tselectbuffer
noremap <m-b> :TSelectBuffer<cr>
inoremap <m-b> <c-o>:TSelectBuffer<cr>

map <C-t> :tabnew <CR>

" }}}

"{{{ -[ Plugins and Scripts ]-
" taglist
let Tlist_Use_Right_Window = 1
let Tlist_Compart_Format = 1
let Tlist_Show_Menu = 1
let Tlist_Exit_OnlyWindow = 1
let tlist_php_settings = 'php;c:class;f:Functions'

"NerdTree settings
"let NERDTreeHighlightCursorline = 1
let NERDTreeChDirMode = 2
let NERDTreeIgnore=['\.db$', '\~$', '\.pyc$', '^__init__\.py$', '\.jpg$', '\.gif$', '\.png$', '\.pdf$', '^\.rxvt*', '^\.rxvt-unicode-ctkarch', '\.class$']
let NerdTreeMouseMode = 2
let NERDChristmasTree = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeDirArrows = 1
let NERDTreeMinimalUI = 1

"MRU
let MRU_Add_Menu = 0

"PyLint
" Dont run pylint on every write
let g:PyLintOnWrite = 0

" }}}

"{{{ User Commands

" edit rc
:nnoremap <silent> <Leader>v :99tabe $MYVIMRC<CR>
command! Editrc :tabe $MYVIMRC

" reload vimrc
:nnoremap <silent> <Leader>V :exec 'tabdo windo source $MYVIMRC' <bar> exec 'tabdo windo filetype detect' <bar> echo 'vimrc reloaded'<CR>

" trim trailing whitespace
command! TrimTrailingSpace :%s/\s\+$//e

" save system file in case we forgot sudo
command! W exec 'w !sudo tee % > /dev/null' | e!
"}}}
