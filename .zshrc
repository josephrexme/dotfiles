# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# User configuration

# If you come from bash you might have to change your $PATH.
export PATH=bin:node_modules/.bin:$HOME/bin:$HOME/.bin:$HOME/.cargo/bin:$PATH:/usr/local/bin:/usr/local/apache-maven-3.3.9/bin:/usr/local/mysql/bin:$HOME/.jenv/bin:$PATH
if type "$jenv" > /dev/null; then
  eval "$(jenv init -)"
fi

# Rbenv for Ruby
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

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
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export PKG_CONFIG_PATH="/usr/local/opt/qt/lib/pkgconfig"

# FZF config
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS="--reverse --inline-info"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Aliases
alias ls='ls -GFh'
alias deploy='./deploy.sh'
alias publish='./publish.sh'
alias ctags="$(brew --prefix)/bin/ctags"
alias git=hub
alias gsb='git status --short | lolcat'
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
alias ckdev='yarn | lolcat && yarn build:server | lolcat && yarn webpack-dev-server'
alias dotfileson='defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder'
alias dotfilesoff='defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder'
alias stackhawk-audit='docker run -e API_KEY=${HAWK_API_KEY} --rm -v $(pwd):/hawk:rw -it stackhawk/hawkscan:latest'

# Functions

# Override hub to cd into folders after cloning
hub() {
  local tmp=$(mktemp)
  local repo_name

  if [ "$1" = clone ] ; then
    $(brew --prefix)/bin/hub "$@" 2>&1 | tee $tmp
    repo_name=$(awk -F"[ ']+" '/Cloning into/ {print $3}' $tmp)
    rm $tmp
    printf "Changing to directory %s\n" "$repo_name"
    cd "$repo_name"
  else
    $(brew --prefix)/bin/hub "$@"
  fi
}

# Base64 encode and decode
base64encode() {
  echo "$1" | base64
}

base64decode() {
  echo "$1" | base64 --decode
}

# Autojump
[ -f $(brew --prefix)/etc/profile.d/autojump.sh ] && . $(brew --prefix)/etc/profile.d/autojump.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FLASK_APP=blackjack
export FLASK_ENV=development

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
