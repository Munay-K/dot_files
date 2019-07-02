#!/bin/sh

# Technical details for correct shell execution {{{

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

#}}}
# Copying files to current working directory {{{

# Vim {{{

#file with general settings with vim
cp ~/.vimrc 			$directory_vim/
cp -r ~/.vim 			$directory_vim/

#}}}
# ZSH {{{

cp ~/.zshrc $directory_zsh/

#}}}
# Tmux {{{

cp ~/.tmux.conf $directory_tmux/

#}}}
# i3 {{{

cp ~/.config/i3/config $directory_i3/

#}}}
# Zathura {{{

cp ~/.config/zathura/zathurarc $directory_zathura/

#}}}
# Xapplications {{{

cp ~/.Xresources $directory_xapplications/
cp -r ~/.Xresources.d $directory_xapplications/

#}}}
# Ranger {{{

cp ~/.config/ranger/rc.conf $directory_ranger/

#}}}

#}}}
# Saving files in remmote repository {{{

#Delete all files that are cached.
git rm -r --cached .

#Push all files.
git add -A
git commit -m "Monthly backup"
git push origin master

#}}}
