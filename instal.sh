#!/bin/bash

echo "Installing dotfiles..."

cp git/gitconfig ~/.gitconfig
mkdir -p ~/.ssh
cp bash/bashrc ~/.bashrc
cp bash/bash_aliases ~/.bash_aliases

echo "Done."
