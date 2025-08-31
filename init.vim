set shell=/bin/zsh
set shiftwidth=4
set tabstop=2
set expandtab
set textwidth=0
set autoindent
set hlsearch
set clipboard=unnamed
syntax on 

call plug#begin()
Plug 'ntk148v/vim-horizon' "color definition
Plug 'preservim/nerdtree' "display fold tree
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } "fuzzy file finder
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot' "syntax highlight by polyglot
Plug 'neoclide/coc.nvim', {'branch': 'release'} "code completion by coc.nvim
call plug#end()

set termguicolors

colorscheme horizon

let g:lightline = {}
let g:lightline.colorscheme = 'horizon'
let g:lightline = {'colorscheme' : 'horizon'}
let g:gitgutter_highlight_lines =1 "turn on highlighting by default 

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
