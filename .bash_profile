# Architecture Flags
export ARCHFLAGS="-arch x86_64"

# Load .bashrc and .bash_aliases
test -f ~/.bashrc && source ~/.bashrc
test -f ~/.bash_aliases && source ~/.bash_aliases

# Load bash_completion after `brew install bash-completion`
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
fi

# Autojump trigger
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Changing shell structure
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Load Rbenv automatically
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
