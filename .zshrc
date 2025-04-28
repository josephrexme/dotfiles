#######################
# Functions
#######################

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

# Version Management (Ruby, Node, Python)
vm() {
  case $1 in
    rb)
      case $2 in
        ls)
          frum versions
          ;;
        rm)
          frum uninstall $3
          ;;
        *)
          # check if version is installed
          version_found=$(frum versions | grep "$2")
          if [ -z "$version_found" ]; then
            echo "Installing $2"
            frum install $2 --with-openssl-dir=$(brew --prefix openssl@1.1) --with-readline-dir=$(brew --prefix readline)
            frum local $2
          else
            echo "Changing $1 version to $2"
            frum local $2
          fi
          ;;
      esac
      ;;
    js)
      # All commands are inspired by n so it should just work by passing all arguments from 2nd on
      n $2 $3 $4 $5 $6 $7 $8 $9
      ;;
    py)
      case $2 in
        ls)
          pyenv versions
          ;;
        rm)
          pyenv uninstall $3
          ;;
        *)
          if ! pyenv versions | grep -q "$2"; then
            pyenv install $2
          else
            echo "Changing $1 version to $2"
            pyenv global $2
          fi
          ;;
      esac
      ;;
    *)
      # echo "Usage: vm rb|js|py ls|rm|<version>"
      cat <<EOF
Usage: vm ruby|node|py ls|rm|<version>

Examples:
  vm ruby ls
  vm node ls
  vm py ls
  vm node 20.10.0
  vm ruby 3.2.2
  vm py 3.11.6
EOF
      ;;
  esac
}



#######################
# ENV Variables
#######################

export PYENV_ROOT="$HOME/.pyenv"
export N_PREFIX="$HOME/.config/n"

export PATH=bin:node_modules/.bin:$HOME/bin:$HOME/.zprofile:$HOME/.cargo/bin:$N_PREFIX/bin:$PYENV_ROOT/bin:/usr/local/apache-maven-3.3.9/bin:$HOME/.jenv/bin:/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH


# Preferred editor
export EDITOR='vim'

###########################################
# Compilation flags (Caution: OS Specific)
# #########################################
# export ARCHFLAGS="-arch x86_64" <- Bad for Apple M3, Good for Intel
export ARCHFLAGS="-arch arm64" # M-seriese chip
# export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# These are added to allow ruby > 3.2 install on M3 chip
export CPATH="/opt/homebrew/include"
export LIBRARY_PATH="/opt/homebrew/lib"

# FZF config
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS="--reverse --inline-info"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

export PYTHON="$(which python)"
# export MANPATH="/usr/local/man:$MANPATH"
# You may need to manually set your language environment
# export LANG=en_US.UTF-8



#######################
# Initializations
#######################

# Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
  # Setup Theme
  autoload -Uz promptinit
  promptinit
  prompt cloud
fi
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#888888'

# Frum for Ruby (initialize if available and don't err if not)
if command -v "frum" > /dev/null 2>&1; then eval "$(frum init)"; fi
# Chruby initialization
# source $HOMEBREW_PREFIX/opt/chruby/share/chruby/chruby.sh
# source $HOMEBREW_PREFIX/opt/chruby/share/chruby/auto.sh
# Pyenv for Python (initialize if available and don't err if not)
if command -v "pyenv" > /dev/null 2>&1; then eval "$(pyenv init -)"; fi

# Autojump
[ -f $(brew_prefix)/etc/profile.d/autojump.sh ] && . $(brew_prefix)/etc/profile.d/autojump.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source Kit Configurations
if [ -f "${HOME}/.kitrc" ]; then
  source "${HOME}/.kitrc"
fi



########################
# Aliases
########################

alias ls='ls -GFh'
alias deploy='./deploy.sh'
alias publish='./publish.sh'
alias ctags="$(brew_prefix)/bin/ctags"
alias gsb='git status --short'
alias gmn='git checkout main'
alias gpo='git pull origin main'
alias ga='git add'
alias gz='git checkout'
alias gd='git diff'
alias be='WEB_BUNDLER=vite bundle exec'
alias rspec='be rspec -fd --force-color'
alias sidekiq='be sidekiq'
alias jest='./node_modules/.bin/jest'
alias wds='webpack-dev-server'
alias dotfileson='defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder'
alias dotfilesoff='defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder'
alias pressholdon='defaults write -g ApplePressAndHoldEnabled -bool true'
alias pressholdoff='defaults write -g ApplePressAndHoldEnabled -bool false'
alias inspectappson='defaults write -g WebKitDeveloperExtras -bool YES'
alias inspectappsoff='defaults write -g WebKitDeveloperExtras -bool NO'
alias rmpid='rm -f /usr/local/var/postgres/postmaster.pid'
alias disable_fork_safety='export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES'
alias gsqclean='git checkout -q main && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base main $branch) && [[ $(git cherry main $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'



export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
