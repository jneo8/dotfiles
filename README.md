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

### Install dropbox
./install-dropbox.sh

### Install albert

See https://albertlauncher.github.io/gettingstarted/install/linux/

### Install rofi theme

./install-rofi-theme.sh

## mackup

make install-mackup
make cp-makeup-config
make add-i3-bin-cfg-to-mackup
mackup restore

## Install oh-my-zsh 
make install-oh-my-zsh

## Language
make install-pipx
make install uv
make uv-install-basic-pkgs

make install-gvm
make install-rust
```

## Init GVM 


See: https://github.com/moovweb/gvm


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

## Exec light without sudo

https://github.com/haikarainen/light

```bash
sudo chmod +s /usr/bin/light
```


## Final checklist

* [ ] Change default input to fcitx in Input Source setting
* [ ] Dropbox login 
* [ ] Obsidian login
* [ ] Python environment with pipx and uv
* [ ] GVM environment
* [ ] Rust environment
* [ ] color-terminal
* [ ] vim PlugInstall
* [ ] vim GoInstallBinaries
* [ ] reboot after all finish
