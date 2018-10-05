#!/bin/bash

# Installing required for hyperVim packages
sudo pacman -S --needed vim git python jdk8-openjdk cmake

# Installing amix/vimrc awesome vim scheme.
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

# Installing Vundle to manage your plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp ./Vundle.vim ~/.vim_runtime/vimrcs/Vundle.vim

# Adding Vundle in ~/.vimrc
sed -i '3isource ~/.vim_runtime/vimrcs/Vundle.vim'

# Installing plugins

vim +PluginInstall +qall

# Compiling autocomplete engines

cd ~/.vim/bundle/YouCompleteMe/
git submodule update --init --recursive
python3  install.py --java-completer
# Also you can add completetion support for following languages by adding these lines as parameters:
# Go: --go-completer
# C#: --cs-completer
# Rust: --rust-completer
# Full documentation you can find here: https://github.com/Valloric/YouCompleteMe

