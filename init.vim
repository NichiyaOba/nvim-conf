set shell=/bin/zsh
set shiftwidth=4
set tabstop=4
set expandtab
set textwidth=0
set autoindent
set hlsearch
set clipboard=unnamed
syntax on 

call plug#begin()
Plug 'ntk148v/vim-horizon'
Plug 'preservim/nerdtree'
call plug#end()

set termguicolors

colorscheme horizon

let g:lightline = {}
let g:lightline.colorscheme = 'horizon'

let g:lightline = {'colorscheme' : 'horizon'}
