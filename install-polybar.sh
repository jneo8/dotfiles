#!/bin/bash

# For compiling detail: https://github.com/polybar/polybar/wiki/Compiling#compiling

cd /tmp && \
    git clone --depth 1 --branch 3.6.3 --recursive https://github.com/polybar/polybar.git && \
    cd /tmp/polybar && \
    pyenv local system && \
    # compile & install
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(nproc) && \
    sudo make install

rm -rf /tmp/polybar
