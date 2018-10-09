"
" Vimrc - Joseph Rex <silverdust>
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
" Create one if the directory doesn't exist
if empty(glob("~/.vim/undodir"))
  execute '!mkdir ~/.vim/undodir'
endif


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

  " Close current buffer
  nnoremap <Leader>s :bd<CR>

  " Map no highlight to <esc> key
  nnoremap <esc> :noh<return><esc>
  nnoremap <Tab>2 :set tabstop=2<CR>
  nnoremap <Tab>4 :set tabstop=4<CR>
  " Plug install
  nnoremap <Leader>i :PlugInstall<CR>
  " Plug Clean
  nnoremap <Leader>un :PlugClean<CR>
  " UltiSnips Edit
  nnoremap <Leader>ue :UltiSnipsEdit<CR>
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
  " mocha Test current file only
  nnoremap mT :!mocha %<CR>
  " run tests in node: npm test
  nnoremap rT :!npm test<CR>
  " Toggle invisible tabs and trails
  nnoremap <Leader>in :set list!<CR>
  " Highlight all
  nnoremap <C-a> ggVG

" }}}
