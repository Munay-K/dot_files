" ------------------------------------------------------------
" _[1]_ Vundle requirements (don't touch)
" ------------------------------------------------------------

set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'SirVer/ultisnips' 					"Snippets
Plugin 'scrooloose/nerdtree' 				"File manager within Vim
Plugin 'prettier/vim-prettier'				"Prettier

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on 

" ------------------------------------------------------------
" _[1]_ Link to external files
" ------------------------------------------------------------

source ~/.vim/.vimrcs/root_vanilla.vim
source ~/.vim/.vimrcs/plugin_settings_nerdtree.vim
source ~/.vim/.vimrcs/plugin_settings_ultisnips.vim
source ~/.vim/.vimrcs/plugin_settings_vim_prettier.vim

