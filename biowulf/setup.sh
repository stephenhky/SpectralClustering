#!/bin/bash

# making a folder for installing modules and modules
cd $HOME
if [ ! -f $HOME/installing ]; then
  mkdir installing
fi
if [ ! -f $HOME/modules ]; then
  mkdir modules
fi
cd installing

# loading pre-existing packages
#module load LAPACK/3.8.0/gcc-7.2.0-64    # loaded in python/3.7
module load load python/3.7     # with openBLAS, LAPACK

# installing cmake
if [ ! -f $HOME/installing/cmake ]; then
  mkdir cmake
fi
cd cmake
wget https://github.com/Kitware/CMake/releases/download/v3.17.2/cmake-3.17.2.tar.gz
tar xvzf cmake-3.17.2.tar.gz
mkdir $HOME/modules/cmake
cd cmake-3.17.2/
./configure --prefix=$HOME/modules/cmake
./bootstrap
make
make install
export PATH=$HOME/modules/cmake/bin:$PATH

# installing ARPACK
git clone https://github.com/yuj-umd/arpackpp.git
cd arpackpp
./install-openblas.sh
./install-arpack-ng.sh
