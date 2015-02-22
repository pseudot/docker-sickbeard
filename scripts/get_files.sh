#!/bin/bash
if [ ! -z "$1" ]; then
  LOC=$1
  LOC2=$LOC1
else 
  LOC=/tmp
  LOC2=/opt
fi

# Get setuptools
echo Downloading setuptools
if [ ! -d "$LOC/python" ]; then
  mkdir $LOC/python
fi
wget https://bootstrap.pypa.io/ez_setup.py --no-check-certificate -O $LOC/python/ez_setup.py -nv 

# download pyopenssl
echo Downloading pyOpenSSL
wget --no-check-certificate https://pypi.python.org/packages/source/p/pyOpenSSL/pyOpenSSL-0.14.tar.gz -O $LOC/python/pyOpenSSL.tar.gz -nv 
mkdir /tmp/pyOpenSSL.tar.gz
tar -zxf $LOC/python/pyOpenSSL.tar.gz -C /tmp/pyOpenSSL.tar.gz

# Download cheetah
echo Downloading cheetah
wget --no-check-certificate http://pypi.python.org/packages/source/C/Cheetah/Cheetah-2.4.4.tar.gz -O $LOC/python/cheetah.tar.gz  -nv 
mkdir /tmp/cheetah.tar.gz
tar -zxf $LOC/python/cheetah.tar.gz -C /tmp/cheetah.tar.gz

# Clone Sickbeard
echo Cloning sickbeard repo
if [ -d "$LOC2/sickbeard" ]; then
  rm -rf $LOC2/sickbeard
fi
mkdir $LOC2/sickbeard
git clone -b master git://github.com/midgetspy/Sick-Beard.git $LOC2/sickbeard
