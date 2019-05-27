#!/bin/sh

# ------------------------------------------------------------
# ////////////////////////////////////////////////////////////
# Technical details for correct shell execution
# ////////////////////////////////////////////////////////////
# ------------------------------------------------------------

BASEDIR=$(dirname "$0")
cd $BASEDIR

directory_vim=Vim
directory_zsh=ZSH
directory_tmux=Tmux
directory_i3=i3
directory_zathura=Zathura

rm -rf $directory_vim/* ; $directory_vim/.*
rm -rf $directory_zsh/* ; $directory_zsh/.*
rm -rf $directory_tmux/* ; $directory_tmux/.*
rm -rf $directory_i3/* ; $directory_i3/.*
rm -rf $directory_zathura/* ; $directory_zathura/.*

# ------------------------------------------------------------
# ////////////////////////////////////////////////////////////
# Copying files to current directory
# ////////////////////////////////////////////////////////////
# ------------------------------------------------------------

# ------------------------------------------------------------
# Vim files
# ------------------------------------------------------------

#file with general settings with vim
cp ~/.vimrc 			vim/
#Snipptets
cp -r ~/.vim/MySnippets vim/
#Useful scripts to be used in vim
cp -r ~/.vim/plugin 	vim/
#separate .vimrc files
cp -r ~/.vim/.vimrcs 	vim/

# ------------------------------------------------------------
# zsh files
# ------------------------------------------------------------

cp ~/.zshrc zsh/

# ------------------------------------------------------------
# tmux files
# ------------------------------------------------------------

cp ~/.tmux.conf tmux/

# ------------------------------------------------------------
# i3 files
# ------------------------------------------------------------

cp ~/.config/i3/config i3/

# ------------------------------------------------------------
# Zathura files
# ------------------------------------------------------------

cp ~/.config/zathura/zathurarc zathura/

# ------------------------------------------------------------
# ////////////////////////////////////////////////////////////
# Pushing all files to remote repoository
# ////////////////////////////////////////////////////////////
# ------------------------------------------------------------

git add -A
git commit -m "Monthly backup"
git push origin master
