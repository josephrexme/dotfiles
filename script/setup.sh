# Install necessities
apt-get update
apt-get install -y \
  zsh \
  vim \
  htop \
  curl

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


