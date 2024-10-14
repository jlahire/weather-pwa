#!/usr/bin/env bash

# exit/debug
set -e
set -x

# node.js
echo "Installing Node.js..."
curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh -o install_nvm.sh
bash install_nvm.sh
source ~/.nvm/nvm.sh
nvm install 14
nvm use 14

# python stuff with error catching hopefully
echo "Downloading Python 3.8..."
curl -O https://www.python.org/ftp/python/3.8/Python-3.8.tgz
echo "Verifying download..."
if ! tar tzf Python-3.8.tgz >/dev/null; then
    echo "Download corrupted, retrying..."
    curl -O https://www.python.org/ftp/python/3.8/Python-3.8.tgz
    if ! tar tzf Python-3.8.tgz >/dev/null; then
        echo "Download failed again. Exiting..."
        exit 1
    fi
fi
tar xzf Python-3.8.tgz
cd Python-3.8
./configure --prefix=$HOME/.localpython --with-tcltk-includes='-I/usr/include' --with-tcltk-libs='-L/usr/lib -ltcl8.6 -ltk8.6' LDFLAGS="-lgcc_s"
make
make install
cd ..
export PATH=$HOME/.localpython/bin:$PATH
python3.8 --version

# virtual environment
echo "Creating virtual environment..."
python3.8 -m venv venv
source venv/bin/activate

# python setup
python --version
echo "Upgrading pip..."
python -m pip install --upgrade pip
echo "Installing dependencies..."
pip install -r requirements.txt

# copy things
mkdir -p .netlify/functions/python
cp -r venv .netlify/functions/
cp -r $HOME/.localpython .netlify/functions/python/
cp app.py .netlify/functions/

echo "Installation complete!"
