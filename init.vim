" Vim configuration.

"""""""""""""""""""""""""""""
" Built-in system settings. "
"""""""""""""""""""""""""""""
set number
set nowrap
set ignorecase
set smartcase
set expandtab
set shiftwidth=2

" Show whitespace chars (tabs, trailing spaces)
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
" Key mappings "
""""""""""""""""

let mapleader = ","
let maplocalleader = ";"

map Y  y$
map <leader>v :vsp<CR>
map <leader>w   ^Ww
map <leader>=   ^W=
map <leader>j   ^Wj
map <leader>k   ^Wk

vmap <tab>  >gv
vmap <S-tab> <gv

vmap <leader>s :s/
nmap <leader>s :%s/

nmap <space> <C-d>
vmap <space> <C-d>

map \  :NERDTreeToggle<CR>
map \| :NERDTreeFind<CR>

"""""""""""""""""""""
" Plugin Management "
"""""""""""""""""""""
call plug#begin('~/.vim/plugged')

function! DoRemote(arg)
	UpdateRemotePlugins
endfunction

" Add plugins here...
Plug 'neomake/neomake'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'benekastah/neomake', {'on': 'Neomake'}
Plug 'bogado/file-line'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'flazz/vim-colorschemes'
Plug 'junegunn/vim-easy-align'
Plug 'kien/rainbow_parentheses.vim'
Plug 'isRuslan/vim-es6', { 'for': 'javascript' }
Plug 'sheerun/vim-polyglot'
Plug 'jamessan/vim-gnupg'
Plug 'jbgutierrez/vim-babel', { 'for': 'javascript' }
Plug 'mustache/vim-mustache-handlebars', { 'for' : 'mustache' }
Plug 'rking/ag.vim'
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }
Plug 'terryma/vim-multiple-cursors'
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'racer-rust/vim-racer'
Plug 'nsf/gocode'
Plug 'wting/rust.vim'
Plug 'cespare/vim-toml'
Plug 'OmniCppComplete'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-fugitive'
Plug 'shougo/neosnippet.vim'
Plug 'shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'plasticboy/vim-markdown'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

call plug#end()

""""""""""""""""""
" Plugin Options "
""""""""""""""""""

colorscheme cleanroom
set background=dark
let g:airline_theme = 'cool'
" let g:lightline = { 'colorscheme': 'gotham256'}

" Configuration for CtrlP
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\.git$\|\.hg$\|\.svn$',
      \ 'file': '\.exe$\|\.so$\|\.dll$',
      \ }

let g:ctrlp_user_command = {
      \   'types': {
      \       1: ['.git/', 'cd %s && git ls-files']
      \   },
      \   'fallback': 'find %s -type f | head -' . 10000
      \ }

" Snippets via neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_or_jump)

" Tab autocomplete via deoplete
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<tab>"

" Enable rainbow delimiters 

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Pad comment delimeters with spaces
let NERDSpaceDelims = 1

" Small default width for NERDTree pane
let g:NERDTreeWinSize = 20

" Change working directory if you change root directories
let g:NERDTreeChDirMode=2

" add snippet directory
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory = "~/.vim/plugged/vim-snippets/snippets"

" Deoplete settings
let g:deoplete#enable_at_startup=1
if !exists('g:deoplete#omni#input_patterns')
	let g:deoplete#omni#input_patterns = {}
endif

" Git blame
map <leader>g   :Gblame<CR>

" CtrlP
nmap <leader>t  :CtrlPCurWD<CR>
nmap <leader>b  :CtrlPBuffer<CR>
nmap <leader>m  :CtrlPMRU<CR>

" Neomake
nmap <leader>a :Neomake<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Whitespace & highlighting & language-specific config "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd! BufWritePost,BufEnter * Neomake

" Strip trailing whitespace for code files on save
" C family
autocmd BufWritePre *.m,*.h,*.c,*.mm,*.cpp,*.hpp :%s/\s\+$//e

" Ruby, Rails
autocmd BufWritePre *.rb,*.yml,*.js,*.json,*.css,*.less,*.sass,*.html,*.xml,*.erb,*.haml,*.feature :%s/\s\+$//e
au BufRead,BufNewFile *.thor set filetype=ruby
au BufRead,BufNewFile *.god set filetype=ruby
au BufRead,BufNewFile Gemfile* set filetype=ruby
au BufRead,BufNewFile Vagrantfile set filetype=ruby
au BufRead,BufNewFile soloistrc set filetype=ruby

" Java, PHP
autocmd BufWritePre *.java,*.php :%s/\s\+$//e

" Highlight JSON files as javascript
autocmd BufRead,BufNewFile *.json,*.template set filetype=javascript

" Highlight EDN as Clojure
autocmd BufRead,BufNewFile *.edn set filetype=clojure

" Highlight Jasmine fixture files as HTML
autocmd BufRead,BufNewFile *.jasmine_fixture set filetype=html

" Consider question/exclamation marks to be part of a Vim word.
autocmd FileType ruby set iskeyword=@,48-57,_,?,!,192-255
autocmd FileType scss set iskeyword=@,48-57,_,-,?,!,192-255

" Locate Rust source code path
let $RUST_SRC_PATH="/home/ckruse/src/rustc-1.9.0/src"
let g:racer_cmd = "/home/ckruse/.cargo/bin/racer"

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

" Disable 'ex' mode
map Q <Nop>

