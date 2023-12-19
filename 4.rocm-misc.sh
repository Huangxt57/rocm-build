#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/common.sh

git clone https://github.com/ROCm/rocminfo $ROCM_TMP_DIR/rocminfo -b rocm-$ROCM_VERSION --depth 1
git clone https://github.com/ROCm/rocm_smi_lib $ROCM_TMP_DIR/rocm_smi -b rocm-$ROCM_VERSION --depth 1
git clone https://github.com/ROCm/rocm-cmake $ROCM_TMP_DIR/rocm-cmake -b rocm-$ROCM_VERSION --depth 1
git clone https://github.com/ROCm/amdsmi $ROCM_TMP_DIR/amdsmi -b rocm-$ROCM_VERSION --depth 1

pushd $ROCM_TMP_DIR/rocminfo
cmake -S . -B build -G "Ninja" \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX=$ROCM_INSTALL_PREFIX \
-DCMAKE_PREFIX_PATH=$ROCM_INSTALL_PREFIX
cmake --build build
cmake --build build -t install
popd

pushd $ROCM_TMP_DIR/rocm_smi
cmake -S . -B build -G "Ninja" \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX=$ROCM_INSTALL_PREFIX
cmake --build build
cmake --build build -t install
popd

pushd $ROCM_TMP_DIR/rocm-cmake
cmake -S . -B build -G "Ninja" \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX=$ROCM_INSTALL_PREFIX
cmake --build build
cmake --build build -t install
popd
 
pushd $ROCM_TMP_DIR/amdsmi
cmake -S . -B build -G "Ninja" \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX=$ROCM_INSTALL_PREFIX
cmake --build build
cmake --build build -t install
popd

