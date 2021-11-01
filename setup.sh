#!/usr/bin/env bash

echo "Begin setting up Joseph's environment"

# Install necessities
apt-get update

## Prevent interactive questions from apt/dpkg
# `echo |` sends a return to STDIN for prompts
echo | DEBIAN_FRONTEND=noninteractive apt-get install -y \
  zsh \
  vim \
  git \
  tmux \
  htop \
  curl

# Install homebrew because it's easier to control than apt
echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install gcc

# My brews needed by my zshconfig
brew install hub
brew install lolcat

# Install prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Change to zsh
# chsh -s "$(which zsh)" <- Getting PAM auth failure on this


# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Done setting up Joseph's environment"

