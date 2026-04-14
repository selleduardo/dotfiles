#!/bin/bash

echo "Installing dotfiles..."

ln -sf ~/dotfiles/git/gitconfig ~/.gitconfig
mkdir -p ~/.ssh
ln -sf ~/dotfiles/bash/bashrc ~/.bashrc
ln -sf ~/dotfiles/bash/bash_aliases ~/.bash_aliases

echo "Done."
