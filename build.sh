#!/usr/bin/env bash
# Exit
set -e
# Install
echo "Installing Python...becasuse I'm annoying...."
curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 14
nvm use 14
# Install
echo "Installing pyenv..."
curl https://pyenv.run | bash
# Add to path
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
# Install
pyenv install 3.8.0
pyenv global 3.8.0
# Upgrade
python -m pip install --upgrade pip
# Install
pip install -r requirements.txt
echo "finally....done....installing...this...thing....enjoy!"