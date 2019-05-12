#!/bin/sh

# -------------------------------------------------------
# ///////////////////////////////////////////////////////
# Technical details for correct shell execution
# ///////////////////////////////////////////////////////
# -------------------------------------------------------

BASEDIR=$(dirname "$0")

cd $BASEDIR

rm -rf vim/*
rm -rf zsh/*
rm -rf tmux/*
rm -rf i3/*

# -------------------------------------------------------
# ///////////////////////////////////////////////////////
# Copying files to current directory
# ///////////////////////////////////////////////////////
# -------------------------------------------------------

# -------------------------------------------------------
# Vim files
# -------------------------------------------------------

#file with general settings with vim
cp ~/.vimrc vim/
#Snipptets
cp -r ~/.vim/MySnippets vim/
#Useful scripts to be used in vim
cp -r ~/.vim/plugin vim/
#Selected color schemes
cp -r ~/.vim/colors vim/
#Templates used with the vim/templates plugin
cp -r ~/.vim/templates vim/

# -------------------------------------------------------
# zsh files
# -------------------------------------------------------

cp ~/.zshrc zsh/

# -------------------------------------------------------
# tmux files
# -------------------------------------------------------

cp ~/.tmux.conf tmux/

# -------------------------------------------------------
# i3 files
# -------------------------------------------------------

cp ~/.config/i3/config i3/

# -------------------------------------------------------
# ///////////////////////////////////////////////////////
# Pushing all files to remote repoository
# ///////////////////////////////////////////////////////
# -------------------------------------------------------

git add -A
git commit -m "Monthly backup"
git push origin master
