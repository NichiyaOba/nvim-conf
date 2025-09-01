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
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter' "display file change like a VSCode
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

" Shortcut for Git operation
command! Gs Git status      " show git status
command! Ga Git add %       " stage current file
command! Gc Git commit      " commit changes
command! Gp Git push        " push commits
command! Gl Git log --oneline --graph --decorate --all " show git log (pretty)
command! Gd Git diff        " show git diff


"Shortcut for search by fzf
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fh :History<CR>

