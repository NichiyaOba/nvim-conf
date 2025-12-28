" ==================================================
" 基本設定
" ==================================================
set shell=/bin/zsh
set encoding=UTF-8
set clipboard=unnamed
set termguicolors

set shiftwidth=4
set tabstop=2
set expandtab
set textwidth=0
set autoindent

set hlsearch
set splitright

" 行番号・表示系
set number                 " 絶対行番号
set norelativenumber       " 相対行番号オフ
set numberwidth=2
set cursorline
set signcolumn=auto:1


" ==================================================
" プラグイン管理 (vim-plug)
" ==================================================
call plug#begin()

" カラースキーム
Plug 'ntk148v/vim-horizon'
Plug 'folke/tokyonight.nvim'

" ファイル / UI
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'nvim-lua/plenary.nvim'
Plug 'NeogitOrg/neogit'
Plug 'sindrets/diffview.nvim'

" 開発支援
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-ts-autotag'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'

" 言語別
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'hashivim/vim-terraform'

call plug#end()


" ==================================================
" カラースキーム設定
" ==================================================
colorscheme tokyonight

lua << EOF
require("tokyonight").setup({
  lsp_semantic_tokens = true,
})
EOF


" ==================================================
" Leader キー
" ==================================================
let mapleader = "\<Space>"

" ==================================================
" nvim-tree
" ==================================================
nnoremap <leader>e :NvimTreeToggle<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
autocmd VimEnter * if argc() == 1 | NvimTreeOpen | endif


lua << EOF
require("nvim-tree").setup({
  disable_netrw = true,
  hijack_netrw = true,

  view = {
    width = 30,
    side = "left",
  },

  renderer = {
    highlight_git = true,
    highlight_opened_files = "name",
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },

  filters = {
    dotfiles = false, -- ドットファイル表示
  },

  update_focused_file = {
    enable = true,       -- ★ VSCode ライクの核心
    update_root = false,
  },

  actions = {
    open_file = {
      quit_on_open = false,
    },
  },
})
EOF


" ==================================================
" Git コマンド
" ==================================================
command! Gs Git status
command! Ga Git add %
command! Gc Git commit
command! Gp Git push
command! Gl Git log --oneline --graph --decorate --all
command! Gd Git diff
command! Gds Gdiffsplit!

lua << EOF
require('neogit').setup({
  integrations = { diffview = true },
})
EOF
nnoremap <leader>gg :Neogit kind=split<CR>


" ==================================================
" fzf
" ==================================================
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fh :History<CR>

" --- Files: 右 split で開く ---
function! s:open_file_in_right_vsplit(lines) abort
  for l:file in a:lines
    if empty(l:file) | continue | endif
    execute 'rightbelow vsplit' fnameescape(l:file)
  endfor
endfunction

command! -nargs=* FilesRight call fzf#vim#files(
  \ <q-args>,
  \ fzf#vim#with_preview({'sink*': function('s:open_file_in_right_vsplit')}),
  \ 0)

nnoremap <leader>ff :FilesRight<CR>

" --- Rg: 右 split + 行ジャンプ ---
function! s:open_in_right_vsplit(lines) abort
  if len(a:lines) < 2 | return | endif
  let l:parts = split(a:lines[1], ':', 1)
  if len(l:parts) < 3 | return | endif

  execute 'rightbelow vsplit' fnameescape(l:parts[0])
  call cursor(str2nr(l:parts[1]), str2nr(l:parts[2]))
  normal! zvzz
endfunction

command! -nargs=* Rg call fzf#vim#grep(
  \ 'rg --column --line-number --no-heading --hidden --smart-case --glob "!.git/*" '
  \ . shellescape(<q-args>),
  \ 1,
  \ fzf#vim#with_preview({'sink*': function('s:open_in_right_vsplit')}),
  \ 0)

nnoremap <leader>fg :Rg<CR>


" ==================================================
" Coc / LSP
" ==================================================
nnoremap <silent> gd :call CocAction('jumpDefinition', 'vsplit')<CR>
nnoremap <silent> gy :call CocAction('jumpTypeDefinition', 'vsplit')<CR>
nnoremap <silent> gi :call CocAction('jumpImplementation', 'vsplit')<CR>
nnoremap <silent> gr :call CocAction('jumpReferences', 'vsplit')<CR>

inoremap <expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"


" ==================================================
" 保存時フック（言語別）
" ==================================================
" JS / TS
autocmd BufWritePre *.ts,*.tsx,*.js,*.jsx
      \ :silent! call CocAction('runCommand', 'editor.action.organizeImport')

" Go
autocmd BufWritePre *.go :silent! call CocAction('organizeImport')
autocmd BufWritePre *.go :silent! call CocAction('format')

" Terraform
autocmd! BufWritePre *.tf,*.tfvars
let g:terraform_fmt_on_save=1
let g:terraform_align=1


" ==================================================
" ユーティリティ
" ==================================================
" プロジェクトルートからの相対パスをコピー
command! CopyRelativePath let @+ = fnamemodify(expand('%'), ':.')
      \ | echo "Copied: " . fnamemodify(expand('%'), ':.')
nnoremap <leader>y :CopyRelativePath<CR>

