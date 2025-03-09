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
1. Clone git repository
```bash:Usage
$ mkdir dotfiles
$ cd dotfiles
$ git clone https://github.com/LittleBear-6w6/dotfiles.git
$ ln -s ~/dotfiles/.vimrc ~/.vimrc
$ ln -s ~/dotfiles/.mybashrc ~/.mybashrc
```
2. Edit .bashrc
Add below sentence to `.bashrc`
```config:.bashrc
if [ -f ~/.mybashrc ]; then
        . ~/.mybashrc
fi
```
