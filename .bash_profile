# Architecture Flags
export ARCHFLAGS="-arch x86_64"

# Load .bashrc and .bash_aliases
test -f ~/.bashrc && source ~/.bashrc

# Load bash_completion after `brew install bash-completion`
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
fi

# Autojump trigger
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Load Rbenv automatically
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
