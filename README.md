dotfiles
========

* Install NeoBundle

```
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
:NeoBundleInstall
```

* Install RSense

```
yum install java-1.8.0-openjdk wget -y
wget http://cx4a.org/pub/rsense/rsense-0.3.tar.bz2
bzip2 -dc rsense-0.3.tar.bz2 | tar xvf -
cp -r rsense-0.3 /usr/local/lib
chmod +x /usr/local/lib/rsense-0.3/bin/rsense
/usr/local/lib/rsense-0.3/bin/rsense version
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

* indentファイル

```
mkdir ~/.vim/indent
ln -s dotfiles/ruby.vim ~/.vim/indent/
```

* Install tmux

```
yum install http://pkgs.repoforge.org/tmux/tmux-1.6-1.el6.rf.x86_64.rpm
```

* Git completion

```
wget -O ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
wget -O ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
source ~/.git-completion.bash
source ~/.git-prompt.sh
```
