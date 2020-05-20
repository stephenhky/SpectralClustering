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
module load cmake/3.15.2
module load LAPACK/3.8.0/gcc-7.2.0-64    # loaded in python/3.7
module load python/3.7     # with openBLAS, LAPACK
module load CUDA/10.2

# installing ARPACK
cd $HOME/installing
git clone https://github.com/stephenhky/arpackpp    # updated links for SuperLU
cd arpackpp
# openBLAS
./install-openblas.sh    # build
# ARPACK
./install-arpack-ng.sh
# Supernodal LU
./install-superlu.sh
# SuiteSparse
./install-suitesparse.sh

ln -s examples/reverse/sym/rsymsol.h include/rsymsol.h   # very important to link this file or the compilation will fail
cd ..

# FastSC
git clone https://github.com/stephenhky/fastsc
cd fastsc
make
