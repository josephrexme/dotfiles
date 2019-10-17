# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# User configuration

# If you come from bash you might have to change your $PATH.
export PATH=bin:node_modules/.bin:$HOME/bin:$HOME/.cargo/bin:$PATH:/usr/local/bin:/usr/local/apache-maven-3.3.9/bin:/usr/local/mysql/bin:$HOME/.jenv/bin:$PATH
if type "$jenv" > /dev/null; then
  eval "$(jenv init -)"
fi

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# FZF config
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS="--reverse --inline-info"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Aliases
alias ls='ls -GFh'
alias deploy='./deploy.sh'
alias ctags="$(brew --prefix)/bin/ctags"
alias git=hub
alias gsb='git status --short'
alias ga='git add'
alias gz='git checkout'
alias gd='git diff'
alias be='bundle exec'
alias dotfileson='defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder'
alias dotfilesoff='defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder'

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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Autojump
[ -f $(brew --prefix)/etc/profile.d/autojump.sh ] && . $(brew --prefix)/etc/profile.d/autojump.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
