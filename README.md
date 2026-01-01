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

Install git-cz (Conventional Commits CLI): https://github.com/streamich/git-cz

```
npm install -g git-cz
```

<details>
<summary>changelog.config.js (プロジェクトルート or ~/.changelog.config.js に配置)</summary>

グローバルに適用する場合は `~/.changelog.config.js` に配置してください。

```js
module.exports = {
  disableEmoji: false,
  format: '{type}{scope}: {emoji}{subject}',
  list: [
    'feat',
    'test',
    'fix',
    'chore',
    'docs',
    'refactor',
    'style',
    'ci',
    'perf',
    'package',
    'config',
    'WIP',
  ],
  maxMessageLength: 64,
  minMessageLength: 3,
  questions: [
    'type',
    'scope',
    'subject',
    'body',
    'breaking',
    'issues',
    'lerna',
  ],
  scopes: [],
  types: {
    feat: {
      description: '新機能',
      emoji: '🎸',
      value: 'feat',
    },
    chore: {
      description: 'ビルド関連やライブラリの変更',
      emoji: '🤖',
      value: 'chore',
    },
    ci: {
      description: 'CI関連の変更',
      emoji: '🎡',
      value: 'ci',
    },
    docs: {
      description: 'ドキュメントの更新',
      emoji: '✏️',
      value: 'docs',
    },
    fix: {
      description: '不具合の修正',
      emoji: '🐛',
      value: 'fix',
    },
    perf: {
      description: 'パフォーマンス改善',
      emoji: '⚡️',
      value: 'perf',
    },
    refactor: {
      description: 'リファクタリング',
      emoji: '💡',
      value: 'refactor',
    },
    style: {
      description: 'コードの処理に影響しない変更（スペースや書式設定など)',
      emoji: '💄',
      value: 'style',
    },
    test: {
      description: 'テストコード',
      emoji: '💍',
      value: 'test',
    },
    package: {
      description: 'パッケージ',
      emoji: '📦',
      value: 'package',
    },
    config: {
      description: '設定ファイル',
      emoji: '⚙',
      value: 'config',
    },
    WIP: {
      description: '作業途中',
      emoji: '🚧',
      value: 'WIP',
    },
  },
  messages: {
    type: 'プレフィックスを選択:',
    subject: 'コミットのタイトル（概要）を入力(option):\n',
    body: '変更内容の詳細を入力(option):\n',
    breaking: '重大な変更を入力(option):\n',
    issues: '関連するisuueを入力(option), 例 #123:',
  },
};
```

</details>

lazygit でもコミット時に git-cz を使う場合は、以下の設定を `~/Library/Application Support/lazygit/config.yml` (macOS) に追加してください。

```yaml
customCommands:
  - key: 'c'
    context: 'files'
    command: 'git cz'
    description: 'Commit with git-cz'
    subprocess: true
```

It is recommended to add the following configuration to /Users/{user_name}/.zshrc.

```
setopt no_beep             # Disable the terminal beep sound
setopt auto_pushd          # Automatically push the current directory onto the stack when using 'cd'
setopt pushd_ignore_dups   # Prevent duplicate entries in the directory stack
setopt share_history       # Share command history across all zsh sessions
setopt inc_append_history  # Immediately append commands to the history file as they are executed

```
