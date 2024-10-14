#!/usr/bin/env bash
# Exit
set -e
set -x

# node stuff
echo "Installing Node.js...because I'm annoying...."
curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 14
nvm use 14

# python stuff
echo "Installing Python 3.8...still being annoying...."
curl https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tgz | tar xz
cd Python-3.8.12
# added tcl and tk stuff
./configure --with-tcltk-includes='-I/usr/include' --with-tcltk-libs='-L/usr/lib -ltcl8.6 -ltk8.6'
make
make install
cd ..
export PATH=$PWD/python/bin:$PATH

# virtual environment stuff
echo "Creating virtual environment..."
python -m venv venv
source venv/bin/activate

# normal python stuff
python --version
echo "Upgrading pip...almost done being annoying...."
python -m pip install --upgrade pip

# req stuff
echo "Installing dependencies...final bit of annoyance...."
pip install -r requirements.txt

# putting everything togerther
mkdir -p .netlify/functions/python
cp -r python .netlify/functions/
cp app.py .netlify/functions/

echo "finally....done....installing...this...thing....enjoy!"