SHELL := /bin/bash
PYTHON_VERSION ?= "3.8.6"
GO_VERSION ?= "go1.15.2"


##@ Mackup

install-mackup:  ## Install mackup with homebrew
	brew install mackup

cp-mackup-config:  ## Copy mackup config to ~/
	cp ./.mackup.cfg ~/

PHONY: install-mackup cp-mackup-config

##@ Application

apt-install: ## Run ./apt-install.sh
	./apt-install.sh

snap-install:  ## Run ./snap-install.sh
	./snap-install.sh

install-homebrew:
	@bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	echo 'eval $$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> ~/.profile

install-calibre:  ## Install calibre https://calibre-ebook.com/download_linux
	sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

PHONY: apt-install snap-install install-homebrew

##@ Shell

install-oh-my-zsh:  ## Setup zsh
	git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
	cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
	sudo chsh -s $$(which zsh)

PHONY: install-oh-my-zsh

##@ Terminal

color-terminal:  ## Color terminal with goph
	 export TERMINAL=gnome-terminal && $(SHELL) -c "$$(wget -qO- https://git.io/vQgMr)"

PHONY: color-terminal

##@ Pyenv
install-pyenv:  ## Install pyenv
	 curl https://pyenv.run | zsh

pyenv-install-default-python:  ## Install default python
	pyenv install  $(PYTHON_VERSION)
	pyenv global $(PYTHON_VERSION)

python-install-basic-pkg:  ## Install basic package for python
	pip install -U Commitizen flake8 flake8-docstrings

install-poetry:  ## Install python package manager poetry
	curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -

.PHONY: install-pyenv pyenv-install-default-python python-install-basic-pkg install-poetry

##@ gvm

install-gvm:  ## Install gvm
	zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

PHONY: install-gvm

##@ Wallpaper

init-wallpaper:  ## Init wall paper with feh
	feh --bg-fill ~/Dropbox/Img/wallpapers/LuciferAngel.jpeg


PHONY: init-wallpaper

##@ i3

install-i3-gaps:  ## Install i3-gaps from source
	./install-i3-gaps.sh

PHONY: install-i3-gaps

##@ Help

.PHONY: help

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
