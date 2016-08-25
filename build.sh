#!/usr/bin/env bash

ROOT=`pwd`
TAG='3.0.0'

OPENCV_PATH=$ROOT/opencv
BUILD_PATH=$ROOT/.build
CONTRIB_PATH=$ROOT/opencv_contrib

INSTALL=NO
PACK=NO
ONLY_CONFIG=NO
OPENCV=NO
TESSERACT=NO

for i in "$@"
do
    case $i in
        --clean)
            echo "clean build dir ..."
            rm -rf $BUILD_PATH
            shift 
        ;;
        --config)
            ONLY_CONFIG="YES"
            shift 
        ;;
        --install)
            INSTALL="YES"
            shift 
        ;;
        --pack)
            PACK="YES"
            shift 
        ;;
        --tesseract)
            TESSERACT="YES"
            shift 
        ;;
        --opencv)
            OPENCV="YES"
            shift 
        ;;
        *)
        ;;
    esac  
 done

echo "OPENCV    : " "$OPENCV"
echo "TESSERACT : " "$TESSERACT"
echo "PACKAGE   : " "$PACK"
echo "INSTALL   : " "$INSTALL"
echo "CONFIG    : " "$ONLY_CONFIG"
echo "PACKAGE   : " "$PACK"

if [ "$TESSERACT" == "YES" ]; then
    cd tesseract
    ./autogen.sh
    ./configure \
        --with-extra-libraries=/usr/local/lib \
        --with-extra-includes=/usr/local/include \
        LDFLAGS=-L/usr/local/lib \
        CPPFLAGS=-I/usr/local/include
    
    if [ "$ONLY_CONFIG" == "NO" ]; then
        make -j7
        make training -j7
    fi
    
    if [ "$INSTALL" == "YES" ]; then
        sudo make install 
        sudo make training-install 
        make clean
    
        wget https://tesseract-ocr.googlecode.com/files/eng.traineddata.gz
        wget https://tesseract-ocr.googlecode.com/files/rus.traineddata.gz

        gunzip eng.traineddata.gz
        gunzip rus.traineddata.gz

        sudo mv -v eng.traineddata /usr/local/share/tessdata/
        sudo mv -v rus.traineddata /usr/local/share/tessdata/
    fi
fi

if [ "$OPENCV" == "YES" ]; then

    git submodule init && git submodule update

    cd $OPENCV_PATH  && git checkout . && git checkout tags/$TAG
    cd $CONTRIB_PATH && git checkout . && git checkout tags/$TAG

    mkdir -p $BUILD_PATH && cd $BUILD_PATH

    cmake $OPENCV_PATH -G "Unix Makefiles" \
        -DCMAKE_BUILD_TYPE=Release\
        -DOPENCV_WARNINGS_ARE_ERRORS=0 \
        -DOPENCV_EXTRA_MODULES_PATH=$CONTRIB_PATH/modules \
    \
        -DBUILD_opencv_python2=1    \
        -DBUILD_SHARED_LIBS=1       \
    \
        -DBUILD_DOCS=0              \
        -DBUILD_TESTS=0             \
        -DBUILD_EXAMPLES=0          \
        -DBUILD_TBB=0               \
     \
        -DINSTALL_CREATE_DISTRIB=0  \
        -DINSTALL_C_EXAMPLES=0      \
        -DINSTALL_PYTHON_EXAMPLES=0 \
        -DINSTALL_TESTS=0           \
    \
        -DWITH_GTK=0                \
        -DWITH_QT=0                 \
        -DWITH_VTK=0                \
        -DWITH_MATLAB=0             \
        -DWITH_FFMPEG=0             \
        -DWITH_OPENNI2=0            \
        -DWITH_WIN32UI=0            \
        -DWITH_TBB=0                \
     \
        -DWITH_OPENGL=1             \
        -DWITH_OPENCL=1             \
        -DWITH_EIGEN=1              \
        -DWITH_CUBLAS=1             \
        -DWITH_IPP=1                \
        -DWITH_OPENMP=1             \
        -DWITH_OPENNI=1             \
    \
        -DWITH_CUDA=0               \
        -DBUILD_CUDA_STUBS=0        \
        -DCUDA_FAST_MATH=1          \

    if [ "$ONLY_CONFIG" == "NO" ]; then
        make -j7
    fi    
    if [ "$INSTALL" == "YES" ]; then
        sudo make install 
    fi
fi

######################################################################





