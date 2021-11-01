#!/usr/bin/env bash

# Install necessities
apt-get update

## Prevent interactive questions from apt/dpkg
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  zsh \
  vim \
  git \
  htop \
  curl

# Install prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Change to zsh
chsh -s /bin/zsh
zsh

# Install homebrew because zsh configs use a lot of brew --prefix
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install gcc

# My brews needed by my zshconfig
brew install hub
brew install lolcat


# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


