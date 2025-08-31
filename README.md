
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
