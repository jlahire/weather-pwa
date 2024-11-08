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
echo "Downloading Python 3.8..."
curl -O https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tgz
echo "Verifying download..."
if ! tar tzf Python-3.8.0.tgz >/dev/null; then
    echo "Download corrupted, retrying..."
    curl -O https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tgz
    if ! tar tzf Python-3.8.0.tgz >/dev/null; then
        echo "Download failed again. Exiting..."
        exit 1
    fi
fi
tar xzf Python-3.8.0.tgz
cd Python-3.8.0
./configure --prefix=$HOME/.localpython --with-tcltk-includes='-I/usr/include' --with-tcltk-libs='-L/usr/lib -ltcl8.6 -ltk8.6' LDFLAGS="-lgcc_s"
make
make install
cd ..

# local PATH
export PATH=$HOME/.localpython/bin:$PATH
$HOME/.localpython/bin/python3.8 --version

# virtual environment stuff
echo "Creating virtual environment..."
$HOME/.localpython/bin/python3.8 -m venv $HOME/.netlify/venv
source $HOME/.netlify/venv/bin/activate

# more python stuff
python --version
echo "Upgrading pip..."
python -m pip install --upgrade pip
echo "Installing dependencies..."
pip install -r requirements.txt

# Create the correct directory structure and copy files
mkdir -p netlify/functions/python
cp -r $HOME/.netlify/venv/* netlify/functions/python/
cp weather.py netlify/functions/python/

# confirm directory structure
echo "Directory structure:"
find netlify/functions -type d

echo "Installation complete!"