# Dotfiles

## Install 

```bash
sudo apt update
sudo apt install git make
mkdir ~/Github
cd ~/Github
git clone https://github.com/jneo8/dotfiles.git
cd dotfiles

## Install basic pkg && Application Manager
make apt-install
make snap-install
make homebrew-install

## Application

### Install i3-gaps
make install-i3-gaps

### Install dropbox
./install-dropbox.sh

### Install albert
./install-albert.sh

## mackup

make install-mackup
make cp-makeup-config
mackup restore

## Install oh-my-zsh 
make install-oh-my-zsh

## Language
make install-pyenv
make pyenv-install-default-python
make python-install-basic-pkg

make install-gvm
```


## Init GVM 

```bash
gvm install go1.4 -B
gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT
## Change the version if you need
gvm install go1.15.2
gvm use go1.15.2 --default
```

## Change terminal color

```bash
make color-terminal
```

## Install Nerd Font

See: https://github.com/ryanoasis/nerd-fonts

Change terminal font to Nerd Font after install.

## Install joplin

```
## The script may need to update if i3 already in use
wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash
```


## Final checklist

* [ ] Change default input to gcin in Language support

* [ ] Change default terminal to gnome-terminal
* [ ] Dropbox login 
* [ ] Joplin sync login
* [ ] color-terminal
* [ ] vim PlugInstall
* [ ] vim GoInstallBinaries
* [ ] reboot after all finish
