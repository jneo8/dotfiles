#!/bin/bash

sudo apt update

function install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo apt install -y $1
  else
    echo "Already installed: ${1}"
  fi
}

# Basics
install make
install curl
install file
install git
install htop
install tmux
install vim
install fzf
install wget
install llvm

## Terminal
install zsh
install gnome-terminal
install dconf-cli
install uuid-runtime

## ssh
install ssh
install openssh-server

## Brew
## https://docs.brew.sh/Homebrew-on-Linux

install build-essential

## Python
install libssl-dev
install zlib1g-dev
install libbz2-dev
install libreadline-dev
install libsqlite3-dev
install libncurses5-dev

## i3
install rofi
install compton

## Media
install alsa-utils


###
## Add apt key
###

## albert key
curl https://build.opensuse.org/projects/home:manuelschneid3r/public_key | sudo apt-key add -
echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
sudo wget -nv https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_20.04/Release.key -O "/etc/apt/trusted.gpg.d/home:manuelschneid3r.asc"


###
## End add apt key
###

sudo apt update

install albert
