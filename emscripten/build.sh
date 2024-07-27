#!/bin/bash
EMSCRIPTEN_LIBS_PREFIX="$(pwd)/build"
mkdir $EMSCRIPTEN_LIBS_PREFIX

source /mnt/c/Users/peter/emsdk/emsdk_env.sh

# Build the required FFTW library
pushd emscripten/fftw-3.3.10
emcmake cmake . -DBUILD_TESTS=OFF -DENABLE_THREADS=ON -DBUILD_SHARED_LIBS=OFF -DENABLE_FLOAT=ON -DENABLE_SSE=ON
cmake --build . -j 6
cmake --install . --prefix "$EMSCRIPTEN_LIBS_PREFIX/fftw"
popd

# Build the required Volk library
pushd emscripten/volk-3.1.2
pip install mako
emcmake cmake . -DENABLE_TESTING=OFF
cmake --build . -j 6
cmake --install . --prefix "$EMSCRIPTEN_LIBS_PREFIX/volk"
popd

# Build the required zstd library
pushd emscripten/zstd-1.5.6/build/cmake
emcmake cmake .
cmake --build . -j 6
cmake --install . --prefix "$EMSCRIPTEN_LIBS_PREFIX/zstd"
popd

# And finally, build SDR++
pushd ../build
emcmake cmake ..
cmake --build . -j 6
popd