"
" Vimrc - Joseph Rex <joseph@strich.io>
"

" Vim compatibility over vi
set nocompatible

" UTF-8 Encoding and en_US standard language
set encoding=utf-8

" Terminal colors
set t_Co=256

" Maintain undo history between sessions
set undofile
set undodir=~/.vim/undodir

" Run time path appends {{{

  " set runtime path to include fuzzyfinder
  set rtp+=/usr/local/opt/fzf

" }}}


" Turn off filetype before vundle begins
filetype off

" Install vim-plug if it doesn't exist in autoload directory
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" Begin plugs {{{
call  plug#begin('~/.vim/plugged')

Plug 'mileszs/ack.vim' " {{{
  " Use ag for :Ack searches
  let g:ackprg = 'ag --nogroup --nocolor --column'
" }}}

Plug 'vim-airline/vim-airline' " {{{
  Plug 'vim-airline/vim-airline-themes'
  " Rid off default mode indicator for vim-airline
  set noshowmode
  " Set airline_theme
  let g:airline_theme='papercolor'
  " Enable powerline font symbols
  let g:airline_powerline_fonts = 1
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  " Symbols {{{
    " unicode symbols
    let g:airline_left_sep = '»'
    let g:airline_left_sep = '▶'
    let g:airline_right_sep = '«'
    let g:airline_right_sep = '◀'
    let g:airline_symbols.linenr = '␊'
    let g:airline_symbols.linenr = '␤'
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.paste = 'Þ'
    let g:airline_symbols.paste = '∥'
    let g:airline_symbols.whitespace = 'Ξ'
    " airline symbols
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''
  " }}}
" }}}

Plug 'mattn/emmet-vim'

Plug 'vim-scripts/L9'

Plug 'tomtom/tcomment_vim'

Plug 'ternjs/tern_for_vim'

Plug 'hail2u/vim-css3-syntax'

Plug 'sgur/vim-editorconfig'

Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter'

Plug 'pangloss/vim-javascript' "{{{
  " Highlight JSdocs
  let g:javascript_plugin_jsdoc = 1
  " Syntax highlighting for flow.js
  let g:javascript_plugin_flow = 1
" }}}

Plug 'mxw/vim-jsx'

Plug 'posva/vim-vue'

Plug 'vim-syntastic/syntastic' " {{{
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 1
  let g:syntastic_ignore_files = ['*node_modules*']
  let g:syntastic_javascript_checkers = ['eslint']
" }}}

Plug 'Valloric/YouCompleteMe'

call plug#end()
" }}}

" Determine filetype to add indent and enable plugins
filetype plugin indent on
filetype plugin on
filetype indent on

" Fix backspace indent
set backspace=indent,eol,start

" Turn on Syntax highlighting
syntax enable

" Add line numbers
set number

" How may lines of history to be remembered by vim
set history=500

" Detect and read external changes to file
set autoread

" Reuse the same window and switch from unsaved buffer
set hidden

" Looking at tags
set tags+=tags;$HOME

" Visual autocompletion and ignores
set wildmenu
set wildignore=*.o,*.pyc,*.swp,*.class

" Faster terminal
set ttyfast

" Confirm dialog before file exits
set confirm

" Show partial commands on last line
set showcmd

" Status Line
set laststatus=2 " Show status line

" Show current position
set ruler

" Show file title in terminal
set title


" Searching {{{

  " Highlight search and include partial matches for searches
  set hlsearch
  set incsearch

  " Case insensitive search except when using caps
  set ignorecase
  set smartcase

" }}}


" Indentation {{{

  set autoindent
  set smartindent
  set wrap
  set expandtab
  set shiftwidth=2
  set tabstop=2
  set softtabstop=2

" }}}


" Auto Commands {{{

  " Delete trailing whitespace when files get opened
  autocmd BufWritePre * silent! %s:\(\S*\) \+$:\1:

  " Use tabs in gitconfig
  autocmd BufRead .gitconfig setlocal noexpandtab | %retab!

  " Jump to last line edited
  au BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ | exe "normal! g`\""
      \ | endif

" }}}


" Show matching parenthesis
set showmatch

" Insert tab on the start of a line
set smarttab

" Show invisible tabs and trails
set list
" What invisible tabs and trails show as when toggled on
set listchars=tab:»-,trail:·

" Prevent Beeps
set visualbell
set noerrorbells

" Reducing updattetime from default 4s for vim-gitgutter
set updatetime=250

" A color scheme (More at vimcolors.com)
colorscheme dzo

" Netrw config {{{

  let g:netrw_liststyle = 3
  let g:netrw_banner = 0
  let g:netrw_browse_split = 4
  let g:netrw_winsize = 25
  let g:netrw_altv = 1

" }}}


" Mappings {{{

  " Map leader as space
  let mapleader=' '

  " Map NERDTree to shortcut
  map <C-n> :NERDTreeToggle<CR>

  " Fuzzy Finder map
  nmap <C-p> :FZF<CR>
  " Convert spaces to tabs
  nmap <Leader>tt :set noexpandtab<CR>:%retab!<CR>
  " Convert tabs to spaces
  nmap <Leader>ts :set expandtab<CR>:%retab!<CR>

  " Provide hjkl movements in Insert mode via the <Alt> modifier key
  inoremap <A-h> <C-o>h
  inoremap <A-j> <C-o>j
  inoremap <A-k> <C-o>k
  inoremap <A-l> <C-o>l
  " Fast editing and sourcing of `.vimrc`
  nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
  nnoremap <Leader>sv :source $MYVIMRC<CR>
  nnoremap <Leader>rs :source %<CR>

  " Close active window
  nnoremap <Leader>x :q<CR>

  " Map no highlight to <esc> key
  nnoremap <esc> :noh<return><esc>
  nnoremap <Tab>2 :set tabstop=2<CR>
  nnoremap <Tab>4 :set tabstop=4<CR>
  " Plug install
  nnoremap <Leader>i :PlugInstall<CR>
  " Toggle pasting mode
  nnoremap <Leader>p :set paste!<CR>
  " Toggle light/dark backgrounds
  nnoremap <Leader>bg :let &background = (&background == "dark" ? "light" : "dark")<CR>
  " Strip trailing whitespace
  nnoremap <Leader>ws :%s/ \+$//<CR>
  " Vim-like window navigation
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l
  " `gb` switches to next buffer, like `gt` does with tabs
  nnoremap gb :bn<CR>
  " `gB` switches to previous buffer, like `gT` does with tabs
  nnoremap gB :bp<CR>
  " Toggle invisible tabs and trails
  nnoremap <Leader>in :set list!<CR>
  " Highlight all
  nnoremap <C-a> ggVG

" }}}
