# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Rbenv for Ruby
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


# Aliases
alias ls='ls -GFh'
alias deploy='./deploy.sh'
alias publish='./publish.sh'
alias ctags="$(brew_prefix)/bin/ctags"
alias gsb='git status --short'
alias gmn='git checkout main'
alias ga='git add'
alias gz='git checkout'
alias gd='git diff'
alias be='bundle exec'
alias rails='be rails'
alias rspec='be rspec -fd --force-color'
alias sidekiq='be sidekiq'
alias jest='./node_modules/.bin/jest'
alias wds='webpack-dev-server'
alias cktmux='~/ck-tmux.sh'
alias ckjobs='sidekiq -i 1 -q all'
alias ckdev='yarn | yarn build:server | yarn webpack-dev-server'
alias dotfileson='defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder'
alias dotfilesoff='defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder'
alias pressholdon='defaults write -g ApplePressAndHoldEnabled -bool true'
alias pressholdoff='defaults write -g ApplePressAndHoldEnabled -bool false'


# Functions
brew_prefix() {
  if which brew > /dev/null ; then
    echo "$(brew --prefix)"
  else
    echo ""
  fi
}

# Override hub to cd into folders after cloning
hub() {
  local tmp=$(mktemp)
  local repo_name

  if [ "$1" = clone ] ; then
    $(brew_prefix)/bin/hub "$@" 2>&1 | tee $tmp
    repo_name=$(awk -F"[ ']+" '/Cloning into/ {print $3}' $tmp)
    rm -f $tmp
    printf "Changing to directory %s\n" "$repo_name"
    cd "$repo_name"
  else
    $(brew_prefix)/bin/hub "$@"
  fi
}

# Base64 encode and decode
base64encode() {
  echo "$1" | base64
}

base64decode() {
  echo "$1" | base64 --decode
}

# Delete branches with a match
gbdall() {
  echo "Deleting all branches that match $1"
  git branch | grep "$1" | xargs git branch -D
}

# Autojump
[ -f $(brew_prefix)/etc/profile.d/autojump.sh ] && . $(brew_prefix)/etc/profile.d/autojump.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# ENV Variables

export PATH=bin:node_modules/.bin:$HOME/bin:$HOME/.bin:$HOME/.cargo/bin:$PATH:/usr/local/bin:/usr/local/apache-maven-3.3.9/bin:/usr/local/mysql/bin:$HOME/.jenv/bin:$HOME/Library/Python/3.8/bin:$PATH

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
export LDFLAGS="-L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include"
export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew_prefix openssl@1.1)"
export PKG_CONFIG_PATH="/usr/local/opt/qt/lib/pkgconfig"

# FZF config
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS="--reverse --inline-info"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"
export FLASK_APP=blackjack
export FLASK_ENV=development
export CK_PATH="$HOME/Projects/ConvertKit/convertkit"
export FILEKIT_PATH="$HOME/Projects/ConvertKit/filekit"

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
