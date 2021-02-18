#!/bin/bash

cd /tmp && \
    git clone --depth 1 --branch 4.18.3 https://www.github.com/Airblader/i3 i3-gaps && \
    cd /tmp/i3-gaps && \
    # compile & install
    autoreconf --force --install && \
    rm -rf build/ && \
    mkdir -p build && \
    cd build/ && \

    # Disabling sanitizers is important for release versions!
    # The prefix and sysconfdir are, obviously, dependent on the distribution.
    ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers  && \
    make && \
    sudo make install

rm -rf /tmp/i3-gaps
