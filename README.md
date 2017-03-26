dotfiles
========

* Install dein

```
vim
```

* 必要なgemのインストール

```
gem install rubocop refe2 --no-ri --no-rdoc
bitclust setup
```

* ctagsのインストール

```
yum install ctags -y
brew install ctags
```

* Git completion

```
wget -O ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
wget -O ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
source ~/.git-completion.bash
source ~/.git-prompt.sh
```
