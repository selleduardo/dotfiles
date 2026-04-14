#!/bin/bash

echo "Installing dotfiles..."

cp git/gitconfig ~/.gitconfig
mkdir -p ~/.ssh
cp ssh/config ~/.ssh/config
cp bash/bashrc ~/.bashrc
cp bash/bash_aliases ~/.bash_aliases
cp bash/bash_profiles ~/.bash_profiles

echo "Done."
