SHELL := /bin/bash
PYTHON_VERSION ?= "3.8.6"


##@ Mackup

install-mackup:  ## Install mackup with homebrew
	brew install mackup

##@ Application

apt-install: ## Run ./apt-install.sh
	./apt-install.sh

install-homebrew:
	@bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	echo 'eval $$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> ~/.profile

##@ Terminal

color-terminal:  ## Color terminal with goph
	 export TERMINAL=gnome-terminal && $(SHELL) -c "$$(wget -qO- https://git.io/vQgMr)"

##@ Shell

install-oh-my-zsh:  ## Setup zsh
	git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
	cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
	sudo chsh -s /bin/zsh

##@ Pyenv
install-pyenv:  ## Install pyenv
	 curl https://pyenv.run | zsh

pyenv-install-default-python:  ## Install default python
	pyenv install  $(PYTHON_VERSION)
	pyenv global $(PYTHON_VERSION)

python-install-basic-pkg:  ## Install basic package for python
	pip install -U Commitizen

##@ Help

.PHONY: help

help:  ## Display this help
		    @awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-0-9]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help
