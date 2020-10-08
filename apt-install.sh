#!/bin/bash


function install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo apt install -y $1
  else
    echo "Already installed: ${1}"
  fi
}

add_ppa() {
  grep -h "^deb.*$1" /etc/apt/sources.list.d/* > /dev/null 2>&1
  if [ $? -ne 0 ]
  then
    echo "Adding ppa:$1"
    sudo add-apt-repository -y ppa:$1
    return 0
  fi

  echo "ppa:$1 already exists"
  return 1
}

## Add ppa

## End ppa


sudo apt update


# Basics
install make
install curl
install file
install git
install htop
install tmux
install vim
install vim-nox
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

## i3-gaps
install libxcb1-dev
install libxcb-keysyms1-dev
install libpango1.0-dev
install libxcb-util0-dev
install libxcb-icccm4-dev
install libyajl-dev
install libstartup-notification0-dev
install libxcb-randr0-dev
install libev-dev
install libxcb-cursor-dev
install libxcb-xinerama0-dev
install libxcb-xkb-dev
install libxkbcommon-dev
install libxkbcommon-x11-dev
install autoconf
install libxcb-xrm0
install libxcb-xrm-dev
install automake
install libxcb-shape0-dev

## Media
install alsa-utils
install pavucontrol
install feh

## Language
install gcin

## gvm
install bison

## Nodejs
install nodejs
install npm

