#!/bin/sh

# -------------------------------------------------------
# ///////////////////////////////////////////////////////
# Copying files to current directory
# ///////////////////////////////////////////////////////
# -------------------------------------------------------

# -------------------------------------------------------
# Vim files
# -------------------------------------------------------

cp -r ~/.vim/MySnippets vim/
cp ~/.vimrc vim/

# -------------------------------------------------------
# zsh files
# -------------------------------------------------------

cp ~/.zshrc zsh/

# -------------------------------------------------------
# ///////////////////////////////////////////////////////
# Pushing all files to remote repoository
# ///////////////////////////////////////////////////////
# -------------------------------------------------------

git add -A
git commit -m "Monthly backup"
git push origin master
