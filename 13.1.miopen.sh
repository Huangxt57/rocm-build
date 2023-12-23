#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/common.sh

# git clone -b rocm-$ROCM_VERSION --depth 1 https://github.com/ROCm/MIOpen $ROCM_TMP_DIR/miopen

pushd $ROCM_TMP_DIR/miopen
# cmake -P install_deps.cmake --minimum --prefix
rm -rf build

export LD_LIBRARY_PATH=$ROCM_INSTALL_PREFIX/lib
cmake -S . -B build -G Ninja \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_CXX_COMPILER=$ROCM_INSTALL_PREFIX/bin/clang++ \
-DMIOPEN_BACKEND=HIP \
-DCMAKE_PREFIX_PATH=$ROCM_INSTALL_PREFIX \
-DCMAKE_INSTALL_PREFIX=$ROCM_INSTALL_PREFIX

cmake --build build
cmake --build build -t install
popd

