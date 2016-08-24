#!/usr/bin/env bash

ROOT=`pwd`
TAG='3.0.0'
OPENCV_PATH=$ROOT/opencv
BUILD_PATH=$ROOT/.build
CONTRIB_PATH=$ROOT/opencv_contrib

git submodule init && git submodule update

cd $OPENCV_PATH  && git checkout . && git checkout tags/$TAG
cd $CONTRIB_PATH && git checkout . && git checkout tags/$TAG

mkdir -p $BUILD_PATH
cd $BUILD_PATH

cmake $OPENCV_PATH -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release
    -DOPENCV_WARNINGS_ARE_ERRORS=0 \
    -DOPENCV_EXTRA_MODULES_PATH=$CONTRIB_PATH/modules \
 \
    -DINSTALL_CREATE_DISTRIB=1 \
    -DINSTALL_C_EXAMPLES=0 \
    -DINSTALL_PYTHON_EXAMPLES=0 \
    -DINSTALL_TESTS=0 \
  \
    -DBUILD_DOCS=0 \
    -DBUILD_EXAMPLES=0 \
    -DBUILD_TBB=1 \
    -DBUILD_SHARED_LIBS=1 \
  \
    -DWITH_GTK=0 \
    -DWITH_TBB=0 \
    -DWITH_QT=0 \
    -DWITH_VTK=0 \
    -DWITH_MATLAB=0 \
    -DWITH_OPENGL=0 \
    -DWITH_FFMPEG=0 \
    -DWITH_OPENNI2=0 \
    -DWITH_WIN32UI=0 \
\
    -DWITH_EIGEN=1 \
    -DWITH_CUBLAS=1 \
    -DWITH_OPENCL=1 \
    -DWITH_IPP=1 \
    -DWITH_OPENMP=1 \
    -DWITH_OPENNI=1 \
\
    -DWITH_CUDA=0 \
    -DBUILD_CUDA_STUBS=0 \
    -DCUDA_FAST_MATH=1 \

# make -j4 


#sudo make install

