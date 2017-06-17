# NVM setup
export NVM_DIR="/Users/silverdust/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Require virtualenv for python pip install
export PIP_REQUIRE_VIRTUALENV=true

# Function for updating global packages as exception with pip
gpip(){
  PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

