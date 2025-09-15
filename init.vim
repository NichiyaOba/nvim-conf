set shell=/bin/zsh
set shiftwidth=4
set tabstop=2
set expandtab
set textwidth=0
set autoindent
set hlsearch
set clipboard=unnamed
set encoding=UTF-8
syntax on 

call plug#begin()
Plug 'ntk148v/vim-horizon' "color definition
Plug 'preservim/nerdtree' "display fold tree
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } "fuzzy file finder
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter' "display file change like a VSCode
Plug 'nvim-lua/plenary.nvim'
Plug 'NeogitOrg/neogit'
Plug 'sindrets/diffview.nvim'  
Plug 'ryanoasis/vim-devicons'
Plug 'folke/tokyonight.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-ts-autotag'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'
call plug#end()

set termguicolors
set splitright
set number                 " 絶対行番号
set norelativenumber       " 相対行番号はオフ
set numberwidth=2          " 行番号欄をコンパクトに（2〜3が目安）
set cursorline             " 現在行を見やすく
set signcolumn=auto:1      " 記号欄も最小限に

colorscheme tokyonight


let mapleader = "\<Space>"

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
command! Gds Gdiffsplit!    " vertical diff split of current file (HEAD vs working tree)

" setup（NeovimならOK、VimでもLua有効なら可)
lua << EOF
require('neogit').setup({
  integrations = { diffview = true },
})
EOF
nnoremap <leader>gg :Neogit kind=split<CR>

"Shortcuts for search by fzf
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fh :History<CR>

"Shortcuts for definition jump (右splitで開く)
nnoremap <silent> gd :call CocAction('jumpDefinition', 'vsplit')<CR>
nnoremap <silent> gy :call CocAction('jumpTypeDefinition', 'vsplit')<CR>
nnoremap <silent> gi :call CocAction('jumpImplementation', 'vsplit')<CR>
nnoremap <silent> gr :call CocAction('jumpReferences', 'vsplit')<CR>



" --- Rg: 右側 split で開き、行/桁へもジャンプする ---
function! s:open_in_right_vsplit(lines) abort
  " a:lines[0] はヘッダ（アクションキーなど）、実データは a:lines[1]
  if len(a:lines) < 2 | return | endif
  let l:match = a:lines[1]
  " 形式: path:lnum:col: text...
  let l:parts = split(l:match, ':', 1)
  if len(l:parts) < 3 | return | endif

  let l:file = l:parts[0]
  let l:lnum = str2nr(l:parts[1])
  let l:col  = str2nr(l:parts[2])

  execute 'rightbelow vsplit' fnameescape(l:file)
  call cursor(l:lnum, max([1, l:col]))
  normal! zvzz
endfunction

command! -nargs=* -complete=file Rg call fzf#vim#grep(
  \ 'rg --column --line-number --no-heading --hidden --smart-case --glob "!.git/*" '
  \ . shellescape(<q-args>),
  \ 1,
  \ fzf#vim#with_preview({'sink*': function('s:open_in_right_vsplit')}),
  \ 0)


" --- Files: 選択したファイルを右側 split で開く ---
function! s:open_file_in_right_vsplit(lines) abort
  if empty(a:lines) | return | endif
  " 複数選択に対応（Ctrl-T 等で複数選んだときも全部開く）
  for l:file in a:lines
    if empty(l:file) | continue | endif
    execute 'rightbelow vsplit' fnameescape(l:file)
  endfor
endfunction

" fzf.vim の Files を拡張して右 split で開く
command! -nargs=* FilesRight call fzf#vim#files(
  \ <q-args>,
  \ fzf#vim#with_preview({'sink*': function('s:open_file_in_right_vsplit')}),
  \ 0)

" <Space>ff を右 split バージョンに差し替え
nnoremap <leader>ff :FilesRight<CR>


" 保存前に organize imports を実行
autocmd BufWritePre *.ts,*.tsx,*.js,*.jsx
      \ :silent! call CocAction('runCommand', 'editor.action.organizeImport')

" Enterキーで補完候補を確定（なければ改行）
inoremap <expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"

" プロジェクトルートからの相対パスをクリップボードにコピー
command! CopyRelativePath let @+ = fnamemodify(expand('%'), ':.') | echo "Copied: " . fnamemodify(expand('%'), ':.')
nnoremap <leader>y :CopyRelativePath<CR>

