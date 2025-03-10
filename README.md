# dotfiles
Confiuration files

## List
* Vim
clone .vimrc form h-east/dotfiles_simple at first. And I customize vimrc.  

### Issue
Nothing now.  

[Reference]  
Repository of h-eastさん: https://github.com/h-east/dotfiles_simple

#Usage
## Clone git repository
```bash:Usage
$ mkdir dotfiles
$ cd dotfiles
$ git clone https://github.com/LittleBear-6w6/dotfiles.git
$ ln -s ~/dotfiles/.vimrc ~/.vimrc
$ ln -s ~/dotfiles/.mybashrc ~/.mybashrc
```
## Edit .bashrc
Add below sentence to `.bashrc`
```config:.bashrc
if [ -f ~/.mybashrc ]; then
        . ~/.mybashrc
fi
```

## Setup vim
1. Install Japanese manual
```bash:Install Japanese manual
$cd
$ mkdir -p .vim/pack/my/start
$ mkdir -p .vim/pack/my/opt
$ cd !$
$ git clone https://github.com/vim-jp/vimdoc-ja.git
```
2. Install vim-plug
```bash:Install vim-plug
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

```
3. Setup plugin on vim
(1)Execute vim
(2)Input `:PlugInstall`
Reference:https://github.com/junegunn/vim-plug