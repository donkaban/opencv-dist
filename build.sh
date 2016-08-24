#!/usr/bin/env bash

ROOT=`pwd`

TAG='3.0.0'

OPENCV_PATH=$ROOT/opencv
BUILD_PATH=$ROOT/.build
CONTRIB_PATH=$ROOT/opencv_contrib

if [ $1 == "clean" ]; then
    rm -rf $BUILD_PATH
    exit    
fi

if [ $1 == "tesseract" ]; then
   cd tesseract
    ./autogen.sh
    ./configure \
        --with-extra-libraries=/usr/local/lib \
        --with-extra-includes=/usr/local/include \
        LDFLAGS=-L/usr/local/lib \
        CPPFLAGS=-I/usr/local/include
    make -j4
    sudo make install

    make training -j4
    sudo make training-install

    echo download trained data...
    
    wget https://tesseract-ocr.googlecode.com/files/eng.traineddata.gz
    wget https://tesseract-ocr.googlecode.com/files/rus.traineddata.gz

    gunzip eng.traineddata.gz
    gunzip rus.traineddata.gz

    sudo mv -v eng.traineddata /usr/local/share/tessdata/
    sudo mv -v rus.traineddata /usr/local/share/tessdata/

    rm -fv rus.traineddata.gz
    rm -fv eng.traineddata.gz
fi


git submodule init && git submodule update

cd $OPENCV_PATH  && git checkout . && git checkout tags/$TAG
cd $CONTRIB_PATH && git checkout . && git checkout tags/$TAG

mkdir -p $BUILD_PATH && cd $BUILD_PATH

cmake $OPENCV_PATH -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release\
    -DOPENCV_WARNINGS_ARE_ERRORS=0 \
    -DOPENCV_EXTRA_MODULES_PATH=$CONTRIB_PATH/modules \
\
    -DBUILD_DOCS=0              \
    -DBUILD_TESTS=0             \
    -DBUILD_EXAMPLES=0          \
    -DBUILD_TBB=1               \
    -DBUILD_SHARED_LIBS=1       \
\
    -DINSTALL_CREATE_DISTRIB=0  \
    -DINSTALL_C_EXAMPLES=0      \
    -DINSTALL_PYTHON_EXAMPLES=0 \
    -DINSTALL_TESTS=0           \
\
    -DWITH_GTK=0                \
    -DWITH_TBB=0                \
    -DWITH_QT=0                 \
    -DWITH_VTK=0                \
    -DWITH_MATLAB=0             \
    -DWITH_OPENGL=0             \
    -DWITH_FFMPEG=0             \
    -DWITH_OPENNI2=0            \
    -DWITH_WIN32UI=0            \
\
    -DWITH_EIGEN=1              \
    -DWITH_CUBLAS=1             \
    -DWITH_OPENCL=0             \
    -DWITH_IPP=1                \
    -DWITH_OPENMP=1             \
    -DWITH_OPENNI=1             \
\
    -DWITH_CUDA=0               \
    -DBUILD_CUDA_STUBS=0        \
    -DCUDA_FAST_MATH=1          \

make -j4 

if [ $1 == "install" ]; then
    sudo make install
fi
if [ $1 == "uninstall" ]; then
    sudo make uninstall
fi

if [ $1 == "pack" ]; then
    echo packing...
fi

