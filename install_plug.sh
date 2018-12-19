#!/bin/sh

echo "Installing vim-plug for both vim and neovim..."

URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

# For standard VIM
curl -fLo ~/.vim/autoload/plug.vim --create-dirs $URL

# For Neovim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs $URL

echo "Installation complete. Run \":PlugInstall\" on first run."
