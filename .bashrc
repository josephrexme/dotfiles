# NVM setup
export NVM_DIR="/Users/silverdust/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Require virtualenv for python pip install
export PIP_REQUIRE_VIRTUALENV=true

# Function for updating global packages as exception with pip
gpip(){
  PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

# Changing shell structure
PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
CLICOLOR=1
LSCOLORS=ExFxBxDxCxegedabagacad

test -f ~/.bash_aliases && source ~/.bash_aliases


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# added by travis gem
[ -f /Users/silverdust/.travis/travis.sh ] && source /Users/silverdust/.travis/travis.sh
