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
install cmake
install cmake-data
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
install imagemagick
install tree
install xclip

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
install libffi-dev
install zlib1g-dev
install libbz2-dev
install libreadline-dev
install libsqlite3-dev
install libncurses5-dev
install python3-venv
install python-is-python3
install pipx

## i3
install i3
install rofi
install compton
install i3lock
install i3lock-fancy

## Media
install alsa-utils
install pavucontrol
install feh

## Language
install fcitx5
install fcitx5-chewing

## gvm
install bison

## Nodejs
install nodejs
install npm

## bluetooth
install bluetooth
install bluez
install blueman

## brightness
install light
