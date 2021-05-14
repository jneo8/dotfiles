#!/bin/bash

cd /tmp
git clone https://github.com/noctuid/zscroll
cd zscroll
sudo python3 setup.py install

sudo rm -rf /tmp/zscroll
