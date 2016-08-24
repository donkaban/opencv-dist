#!/usr/bin/env bash

ROOT=`pwd`/..

OPENCV_PATH=$ROOT/external/opencv
BUILD_PATH=$ROOT/external/.opencv_build
CONTRIB_PATH=$ROOT/external/opencv_contrib

cd $OPENCV_PATH
    git checkout .
    git checkout tags/3.0.0
cd $CONTRIB_PATH
    git checkout .
    git checkout tags/3.0.0

mkdir -p $BUILD_PATH
cd $BUILD_PATH

cmake $OPENCV_PATH -G "Unix Makefiles" \
    -DWITH_GTK=0 \
    -DBUILD_DOCS=0 \
    -DBUILD_EXAMPLES=0 \
    -DBUILD_TBB=1 \
    -DOPENCV_EXTRA_MODULES_PATH=$CONTRIB_PATH/modules \
    -DBUILD_SHARED_LIBS=1 \
    -DWITH_OPENGL=0 \
    -DWITH_OPENCL=1 \
    -DWITH_VTK=0 \
    -DWITH_FFMPEG=1 \
    -DWITH_IPP=1 \
    -DWITH_CUDA=0 \
    -DWITH_OPENMP=1 \
    -DINSTALL_CREATE_DISTRIB=0 \
    -DINSTALL_C_EXAMPLES=0 \
    -DINSTALL_PYTHON_EXAMPLES=0 \
    -DINSTALL_TESTS=0 \
    -DOPENCV_WARNINGS_ARE_ERRORS=0 \
    -DBUILD_CUDA_STUBS=0 \
    -DWITH_EIGEN=1 \
    -DWITH_MATLAB=0 \
    -DCUDA_FAST_MATH=1 \
    -DWITH_CUBLAS=1 \
    -DWITH_EIGEN=1 \
    -DWITH_OPENNI=1 \
    -DWITH_OPENNI2=0 \
    -DWITH_WIN32UI=0 \
    -DCMAKE_BUILD_TYPE=Release

make -j4 && sudo make install

