#!/usr/bin/env bash

# Exit on error
set -e
set -x

# node stuff
echo "Installing Node.js..."
curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 14
nvm use 14

# python stuff
echo "Installing Python 3.8..."
curl -O https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tgz
tar xzf Python-3.8.12.tgz
cd Python-3.8.12
./configure --prefix=$HOME/.localpython --with-tcltk-includes='-I/usr/include' --with-tcltk-libs='-L/usr/lib -ltcl8.6 -ltk8.6' LDFLAGS="-lgcc_s"
make
make install
cd ..
# Add local Python to PATH
export PATH=$HOME/.localpython/bin:$PATH

# Create virtual environment
echo "Creating virtual environment..."
python3.8 -m venv venv

# Activate virtual environment
source venv/bin/activate

# normal python stuff
python --version
echo "Upgrading pip..."
python -m pip install --upgrade pip

# req stuff
echo "Installing dependencies..."
pip install -r requirements.txt

# putting everything together
mkdir -p .netlify/functions/python
cp -r venv .netlify/functions/
cp app.py .netlify/functions/

echo "Installation complete!"
