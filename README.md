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

See https://albertlauncher.github.io/installing/

### Install rofi theme

./install-rofi-theme.sh

## mackup

make install-mackup
make cp-makeup-config
make add-polybar-cfg-to-mackup
mackup restore

## Install oh-my-zsh 
make install-oh-my-zsh

## Language
make install-pyenv
make pyenv-install-default-python
make python-install-basic-pkg
make install-poetry

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

## Install obsidian

See: https://obsidian.md
> Use snap install version

## Install On 4k laptop

Add to `~/.profile`

```
export DOTFILE_LAPTOP_MODE=true
```


## Final checklist

* [ ] Change default input to fcitx in Input Source setting
* [ ] Change default terminal to gnome-terminal
* [ ] Dropbox login 
* [ ] Obsidian login
* [ ] color-terminal
* [ ] vim PlugInstall
* [ ] vim GoInstallBinaries
* [ ] reboot after all finish
