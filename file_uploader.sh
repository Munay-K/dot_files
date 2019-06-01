#!/bin/sh

# ------------------------------------------------------------
# ////////////////////////////////////////////////////////////
# Technical details for correct shell execution
# ////////////////////////////////////////////////////////////
# ------------------------------------------------------------

#Go to the directory where this script is located.
BASEDIR=$(dirname "$0")
cd $BASEDIR

directory_vim=Vim
directory_zsh=ZSH
directory_tmux=Tmux
directory_i3=i3
directory_zathura=Zathura
directory_xapplications=Xapplications
directory_ranger=Ranger

rm -rf $directory_vim/* ; rm -rf $directory_vim/.*
rm -rf $directory_zsh/* ; rm -rf $directory_zsh/.*
rm -rf $directory_tmux/* ; rm -rf $directory_tmux/.*
rm -rf $directory_i3/* ; rm -rf $directory_i3/.*
rm -rf $directory_zathura/* ; rm -rf $directory_zathura/.*
rm -rf $directory_xapplications/* ; rm -rf $directory_xapplications/.*
rm -rf $directory_ranger/* ; rm -rf $directory_ranger/.*

# ------------------------------------------------------------
# ////////////////////////////////////////////////////////////
# Copying files to current directory
# ////////////////////////////////////////////////////////////
# ------------------------------------------------------------

# ------------------------------------------------------------
# Vim files
# ------------------------------------------------------------

#file with general settings with vim
cp ~/.vimrc 			$directory_vim/

#Snipptets
#cp -r ~/.vim/MySnippets $directory_vim/

#Useful scripts to be used in vim
#cp -r ~/.vim/plugin 	$directory_vim/

#separate .vimrc files
#cp -r ~/.vim/.vimrcs 	$directory_vim/

#Skeleton for different filetypes
#cp -r ~/.vim/skeletons	$directory_vim/

cp -r ~/.vim 			$directory_vim/

# ------------------------------------------------------------
# zsh files
# ------------------------------------------------------------

cp ~/.zshrc $directory_zsh/

# ------------------------------------------------------------
# tmux files
# ------------------------------------------------------------

cp ~/.tmux.conf $directory_tmux/

# ------------------------------------------------------------
# i3 files
# ------------------------------------------------------------

cp ~/.config/i3/config $directory_i3/

# ------------------------------------------------------------
# Zathura files
# ------------------------------------------------------------

cp ~/.config/zathura/zathurarc $directory_zathura/

# ------------------------------------------------------------
# Xapplications
# ------------------------------------------------------------

cp ~/.Xresources $directory_xapplications/
cp -r ~/.Xresources.d $directory_xapplications/

# ------------------------------------------------------------
# Ranger
# ------------------------------------------------------------

cp ~/.config/ranger/rc.conf $directory_ranger/

# ------------------------------------------------------------
# ////////////////////////////////////////////////////////////
# Pushing all files to remote repoository
# ////////////////////////////////////////////////////////////
# ------------------------------------------------------------

#Delete all files that are cached.
git rm -r --cached .

#Push all files.
git add -A
git commit -m "Monthly backup"
git push origin master
