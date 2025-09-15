Please set the following path (for Mac):

```
/Users/{user_name}/.config/nvim"
```

Install fzf

```
brew install fzf
```

Install vim-fugitive： https://github.com/tpope/vim-fugitive

```
mkdir -p ~/.config/nvim/pack/tpope/start
cd ~/.config/nvim/pack/tpope/start
git clone https://tpope.io/vim/fugitive.git
vim -u NONE -c "helptags fugitive/doc" -c q
```

Install vim-gitgutter： https://github.com/airblade/vim-gitgutter

```
mkdir -p ~/.config/nvim/pack/airblade/start
cd ~/.config/nvim/pack/airblade/start
git clone https://github.com/airblade/vim-gitgutter.git
nvim -u NONE -c "helptags vim-gitgutter/doc" -c q
```

Install vim-commentary：　https://github.com/tpope/vim-commentary

```
mkdir -p ~/.config/nvim/pack/tpope/start
cd ~/.config/nvim/pack/tpope/start
git clone https://tpope.io/vim/commentary.git
vim -u NONE -c "helptags commentary/doc" -c q
```

Install for React development

```
:CocInstall coc-tsserver coc-eslint coc-prettier
```

Install for Go development

```
:CocInstall coc-go
```

and install Go tools

```
go install golang.org/x/tools/gopls@latest
```

install for Go syntax highlighting

```
:TSInstall go
```

Install for Go Syntax Highlighting

```
mkdir -p $(go env GOPATH)/bin
go install golang.org/x/tools/gopls@latest
```

It is recommended to add the following configuration to /Users/{user_name}/.zshrc.

```
setopt no_beep             # Disable the terminal beep sound
setopt auto_pushd          # Automatically push the current directory onto the stack when using 'cd'
setopt pushd_ignore_dups   # Prevent duplicate entries in the directory stack
setopt share_history       # Share command history across all zsh sessions
setopt inc_append_history  # Immediately append commands to the history file as they are executed

```
