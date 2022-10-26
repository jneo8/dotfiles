SHELL := /bin/bash
PYTHON_VERSION ?= "3.9.10"
GO_VERSION ?= "go1.15.2"


##@ Mackup

install-mackup:  ## Install mackup with homebrew
	brew install mackup

cp-mackup-config:  ## Copy mackup config to ~/
	cp ./.mackup.cfg ~/

add-i3-bin-cfg-to-mackup:  ## Add i3-bin cfg file to ~/.mackup
	wget https://raw.githubusercontent.com/jneo8/mackup/feat/i3-bin/mackup/applications/i3-bin.cfg -O ~/.mackup/i3-bin.cfgw

.PHONY: install-mackup cp-mackup-config add-i3-bin-cfg-to-mackup

##@ Application

apt-install: ## Run ./apt-install.sh
	./apt-install.sh

snap-install:  ## Run ./snap-install.sh
	./snap-install.sh

install-homebrew:  ## Install homebrew
	@bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	echo 'eval $$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> ~/.profile

install-calibre:  ## Install calibre https://calibre-ebook.com/download_linux
	sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

.PHONY: apt-install snap-install install-homebrew

##@ Shell

install-oh-my-zsh:  ## Setup zsh
	git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
	cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
	sudo chsh -s $$(which zsh)

.PHONY: install-oh-my-zsh
	n

##@ Terminal

color-terminal:  ## Color terminal with goph
	 export TERMINAL=gnome-terminal && $(SHELL) -c "$$(wget -qO- https://git.io/vQgMr)"

.PHONY: color-terminal

##@ Pyenv
install-pyenv:  ## Install pyenv
	 curl https://pyenv.run | zsh

pyenv-install-default-python:  ## Install default python
	pyenv install  $(PYTHON_VERSION)
	pyenv global $(PYTHON_VERSION)

python-install-basic-pkg:  ## Install basic package for python
	pip install Commitizen flake8 flake8-docstrings mypy pre-commit

install-poetry:  ## Install python package manager poetry
	curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -

.PHONY: install-pyenv pyenv-install-default-python python-install-basic-pkg install-poetry

##@ gvm

install-gvm:  ## Install gvm
	zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

PHONY: install-gvm

##@ Wallpaper

init-wallpaper-lucifer-angel:  ## Init wall paper with feh
	feh --bg-fill ~/Dropbox/Img/wallpapers/LuciferAngel.jpeg

init-wallpaper-whale:  ## Init wall paper with feh
	feh --bg-fill ~/Dropbox/Img/wallpapers/whale.jpg

init-wallpaper-moon-whale:  ## Init wall paper with feh
	feh --bg-fill ~/Dropbox/Img/wallpapers/moon-whale.png

init-wallpaper-silverhand:  ## Init wall paper with feh
	feh --bg-fill ~/Dropbox/Img/wallpapers/Silverhand.jpg

init-wallpaper-jammy-jellyfish:  ## Init wall paper with feh
	feh --bg-fill ~/Dropbox/Img/wallpapers/jammy-jellyfish.jpeg

init-wallpaper-space-art:  ## Init wall paper with feh
	feh --bg-fill ~/Dropbox/Img/wallpapers/space-art-fantasy-art-sky-clouds-wallpaper.jpg


.PHONY: init-wallpaper-lucifer-angel init-wallpaper-whale init-wallpaper-moon-whale init-wallpaper-silverhand init-wallpaper-jammy-jellyfish init-wallpaper-space-art

##@ i3

install-i3-gaps:  ## Install i3-gaps from source
	./install-i3-gaps.sh


.PHONY: install-i3-gaps

##@ polybar

install-polybar:  ## Install polybar
	./install-polybar.sh
	./install-zscroll.sh
	./install-playerctl.sh

relaunch-polybar:  ## Relaunch polybar
	~/.config/polybar/launch.sh

.PHONY: install-polybar relaunch-polybar

##@ device commands

disable-bluetooth:  ## Disable bluetooth on ubuntu
	sudo systemctl disable bluetooth.service

reload-bluetooth:  ## Reload bluetooth
	sudo rfkill block bluetooth
	sudo rfkill unblock bluetooth
	sudo systemctl stop bluetooth
	sudo systemctl restart bluetooth
	sudo systemctl status bluetooth


.PHONY: disable-bluetooth reload-bluetooth


##@ Monitor

list-monitor:  ## Run xrandr --listmonitors
	xrandr --listmonitors

xrandr-left-mirror:  ## Make DP1 output mirror
	xrandr --output DP-1 --scale-from 3456x2160 --auto  --same-as eDP-1

xrandr-left-output-right-of-main:  ## Make DP1 output right of eDP-1
	xrandr --output DP-1 --auto --scale-from 3456x2160 --right-of eDP-1

xrandr-right-output-right-of-main:  ## Make DP3 output right of eDP-1
	xrandr --output DP-1 --auto --scale-from 3456x2160 --right-of eDP-1


,PHONY: listmonitors xrandr-left-output-right-of-main xrandr-right-output-right-of-main xrandr-left-mirror

##@ Help

.PHONY: help

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
