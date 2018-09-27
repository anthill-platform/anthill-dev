#!/usr/bin/env bash

if [[ $EUID -eq 0 ]]; then
  echo "Do not run this script as root." 2>&1
  exit 1
fi

# install Homebrew first
export TRAVIS=1
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# bunch of important packages
brew install git
brew install mysql
brew install rabbitmq
brew install redis

brew install libssl
brew tap sashkab/homebrew-python
brew install https://cdn.anthillplatform.org/brew/python35/python35--3.5.6.high_sierra.bottle.tar.gz

sudo mkdir /usr/local/anthill
sudo chown -R $(id -u):$(id -g) /usr/local/anthill

# setup a virtualenv
sudo easy_install virtualenv

virtualenv -p /usr/local/Cellar/python35/3.5.6/bin/python3.5m /usr/local/anthill/venv

source /usr/local/anthill/venv/bin/activate

# we need latest setuptools
pip install --upgrade pip
pip install setuptools==40.0

pushd ../../common
python setup.py sdist
popd

pushd ../../exec
python setup.py sdist
popd

# start mysql server
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

# create various databases
mysql -h 127.0.0.1 -u root -e "create database dev_admin;"
mysql -h 127.0.0.1 -u root -e "create database dev_login;"
mysql -h 127.0.0.1 -u root -e "create database dev_config;"
mysql -h 127.0.0.1 -u root -e "create database dev_dlc;"
mysql -h 127.0.0.1 -u root -e "create database dev_environment;"
mysql -h 127.0.0.1 -u root -e "create database dev_event;"
mysql -h 127.0.0.1 -u root -e "create database dev_exec;"
mysql -h 127.0.0.1 -u root -e "create database dev_game;"
mysql -h 127.0.0.1 -u root -e "create database dev_leaderboard;"
mysql -h 127.0.0.1 -u root -e "create database dev_message;"
mysql -h 127.0.0.1 -u root -e "create database dev_profile;"
mysql -h 127.0.0.1 -u root -e "create database dev_promo;"
mysql -h 127.0.0.1 -u root -e "create database dev_social;"
mysql -h 127.0.0.1 -u root -e "create database dev_store;"
mysql -h 127.0.0.1 -u root -e "create database dev_static;"
mysql -h 127.0.0.1 -u root -e "create database dev_report;"

# generate private key pair
mkdir ../../.anthill-keys
openssl genrsa -des3 -passout pass:wYrA9O187G71ILmZr67GZG945SgarS4K -out ../../.anthill-keys/anthill.pem 512
openssl rsa -in ../../.anthill-keys/anthill.pem -passin pass:wYrA9O187G71ILmZr67GZG945SgarS4K -outform PEM -pubout -out ../../.anthill-keys/anthill.pub

# start rest of the services
brew services start rabbitmq
brew services start redis