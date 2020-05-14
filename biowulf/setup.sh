#!/bin/bash

# installing cmake
mkdir cmake
cd cmake
wget https://github.com/Kitware/CMake/releases/download/v3.17.2/cmake-3.17.2.tar.gz
tar xvzf cmake-3.17.2.tar.gz
cd cmake-3.17.2/
./configure --prefix=$HOME/cmake
./bootstrap
make
make install
export PATH=$HOME/cmake/cmake-3.17.2/bin:$PATH

# installing ARPACK
git clone https://github.com/yuj-umd/arpackpp.git
cd arpackpp
./install-openblas.sh
./install-arpack-ng.sh
