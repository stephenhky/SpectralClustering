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
module load python/3.7     # with openBLAS, LAPACK

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
cd $HOME/installing
git clone https://github.com/yuj-umd/arpackpp.git
cd arpackpp
# openBLAS
./install-openblas.sh    # build
cd external/OpenBLAS/
mkdir $HOME/modules/OpenBLAS
make PREFIX=$HOME/modules/OpenBLAS install
cd ../..
ln -s $HOME/modules/OpenBLAS/lib/libopenblas.a external/libopenblas.a
# ARPACK
if [ -f $HOME/installing/arpackpp/external/arpack-ng ]; then
  rm -rf $HOME/installing/arpackpp/external/arpack-ng
fi
if [ -f $HOME/installing/arpackpp/external/arpack-ng-build ]; then
  rm -rf $HOME/installing/arpackpp/external/arpack-ng-build
fi
#./install-arpack-ng.sh
set -ex
mkdir -p external
cd external
git clone https://github.com/opencollab/arpack-ng.git
mkdir arpack-ng-build
cd arpack-ng-build
cmake -D BLAS_goto2_LIBRARY=../libopenblas.a ../arpack-ng
make
cd ../
ln -s arpack-ng-build/libarpack.a ./
cd ../