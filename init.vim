" Vim configuration

set number
set nowrap
set ignorecase
set smartcase
set expandtab
set shiftwidth=2

" Show trailing whitespace
set list
set listchars=tab:>\ ,trail:+

set virtualedit=onemore
set showmatch

set splitright
set splitbelow

set wildmode=list:longest
set scrolloff=3
set hidden

set incsearch
set history=1024

set autoread
set noswapfile
set nobackup
set nowritebackup

" Autosave when focus is lost
set autowriteall
autocmd FocusLost * silent! wall

""""""""""""""""
" Key Mappings "
""""""""""""""""

let mapleader = ","
let maplocalleader = ";"

map Q <Nop>
map Y y$
map <leader>v :vsp<CR>
map <leader>w <C-w>w
map <leader>= <C-w>=
map <leader>j <C-w>j
map <leader>k <C-w>k

vmap <tab> >gv
vmap <S-tab> <gv
vmap <leader>s :s/
vmap <space> <C-d>

nmap <leader>s :%s/
nmap <space> <C-d>

"""""""""""""""""""""
" Plugin Management "
"""""""""""""""""""""

call plug#begin("~/.vim/plugged")

" Add plugins here
" Plug 'neomake/neomake'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'flazz/vim-colorschemes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chrisbra/Colorizer'
Plug 'jamessan/vim-gnupg'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
  Plug 'Shougo/neco-vim'
else
  Plug 'ajh17/VimCompletesMe'
endif
Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'farmergreg/vim-lastplace'
call plug#end()

"""""""""""""""""""""""""""""""""
" Plugin-specific Configuration "
"""""""""""""""""""""""""""""""""

" NERDTree
map \ :NERDTreeToggle<CR>
map \| :NERDTreeFind<CR>

let g:NERDTreeWinSize = 20
let g:NERDTreeChDirMode = 2

" NERDCommenter
" Pads comments with a space
let NERDSpaceDelims = 1

" Colorschemes
colorscheme tigrana-256-dark
set background=dark
" Airline
let g:airline_theme = 'cool'

" CtrlP
let g:ctrlp_custom_ignore = {
    \ 'dir': '\.git$\|\.hg$\|\.svn$',
    \ 'file': '\.exe$\|\.so$\|\.dll$',
    \ }

let g:ctrlp_user_command = {
    \   'types': {
    \     1: ['.git/', 'cd %s && git ls-files']},
    \   'fallback': 'find %s -type f | head -' . 10000
    \ }

nmap <leader>t :CtrlPCurWD<CR>
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>m :CtrlPMRU<CR>

" Fugitive (Git)
map <leader>g :Gblame<CR>

" Tagbar
map <leader>r :TagbarOpenAutoClose<CR>

if has('nvim')
  " Deoplete
  let g:deoplete#enable_at_startup = 1
  " UltiSnips
  let g:UltiSnipsExpandTrigger = '<nop>'
  let g:UltiSnipsListSnippets = '<nop>'

  " Language Client
  let g:LanguageClient_serverCommands = {
    \ 'rust': ['rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': [''],
    \ 'python': ['pyls'],
    \ }

else
  " UltiSnips
  let g:UltiSnipsExpandTrigger = '<C-k>'
  let g:UltiSnipsListSnippets = '<F5>'
endif
set tags=gHOME/.vimtags,./tags,./.tags,./.vimtags

""""""""""""""""""""""""""
" Filetype Configuration "
""""""""""""""""""""""""""

" JSON as Javascript
autocmd BufRead,BufNewFile *.json,*.template set filetype=javascript

" EDN as Clojure
autocmd BufRead,BufNewFile *.edn set filetype=clojure

" Strip trailing whitespace for code files on save
" C family
autocmd BufWritePre *.m,*.h,*.c,*.mm,*.cpp,*.hpp :%s/\s\+$//e

" Ruby, Rails
autocmd BufWritePre *.rb,*.yml,*.js,*.json,*.css,*.less,*.sass,*.html,*.xml,*.erb,*.haml,*.feature :%s/\s\+$//e
au BufRead,BufNewFile *.thor set filetype=ruby
au BufRead,BufNewFile *.god set filetype=ruby
au BufRead,BufNewFile Gemfile* set filetype=ruby
" Consider question/exclamation marks to be part of a Vim word.
autocmd FileType ruby set iskeyword=@,48-57,_,?,!,192-255
autocmd FileType scss set iskeyword=@,48-57,_,-,?,!,192-255

" let python have 4 spaces, otherwise there are complaints...
autocmd FileType python setlocal shiftwidth=4

" Set up omnicomplete functions
augroup omnifuncs
  autocmd!
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" Java, PHP
autocmd BufWritePre *.java,*.php :%s/\s\+$//e
