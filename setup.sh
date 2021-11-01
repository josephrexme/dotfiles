#!/usr/bin/env bash

echo "Begin setting up Joseph's environment"

# Install necessities
apt-get update

## Prevent interactive questions from apt/dpkg
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  vim \
  git \
  htop \
  curl

# Install homebrew because it's easier to control than apt
# The echo | is to send a single return via STDIN when installation
# prompts
echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install gcc

# Install zsh with brew because apt will prompt about config
# and it freezes setup
brew install zsh

# My brews needed by my zshconfig
brew install hub
brew install lolcat

# Install prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Change to zsh
# chsh -s "$(which zsh)" <- Getting PAM auth failure on this
zsh


# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


