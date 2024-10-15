#!/usr/bin/env bash

# exit/debug
set -e
set -x

# node.js stuff
echo "Installing Node.js..."
curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh -o install_nvm.sh
bash install_nvm.sh
source ~/.nvm/nvm.sh
nvm install 14
nvm use 14

# python 3.8 stuff
echo "Setting up Python..."
# Use the Python version specified in runtime.txt
PYTHON_VERSION=$(cat runtime.txt)
pyenv install -s $PYTHON_VERSION
pyenv global $PYTHON_VERSION

# local PATH
export PATH=$HOME/.localpython/bin:$PATH
$HOME/.localpython/bin/python3.8 --version

# virtual environment stuff
echo "making a virtual environment..."
python -m venv .venv
source .venv/bin/activate

# more python stuff
python -m pip install --upgrade pip
pip install -r requirements.txt

# put everything in functions dir
mkdir -p netlify/functions
cp -r .venv netlify/functions/python
cp weather.py netlify/functions/
# confirm directory structure because this is getting rediculous...
echo "Directory structure:"
find netlify/functions -type d

echo "Installation complete...hopefully"
