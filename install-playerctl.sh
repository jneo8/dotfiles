#!/bin/bash

wget http://ftp.nl.debian.org/debian/pool/main/p/playerctl/libplayerctl2_2.0.1-1_amd64.deb -P /tmp
wget http://ftp.nl.debian.org/debian/pool/main/p/playerctl/playerctl_2.0.1-1_amd64.deb -P /tmp
sudo dpkg -i /tmp/libplayerctl2_2.0.1-1_amd64.deb /tmp/playerctl_2.0.1-1_amd64.deb

rm /tmp/libplayerctl2_2.0.1-1_amd64.deb /tmp/playerctl_2.0.1-1_amd64.deb
