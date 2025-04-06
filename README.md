# My Configuration

This repository contains my configuration files that I want to share between my
machines.

I am staring with GNU Stow, the long term plan is to switch to Home Manager at
some point
## Brew
Start with installing everything in the Brewfile

## GNU Stow 
Create folders for the different configurations that you want and run:

```console
$ stow "folder"
```
For instance if you want to add the configuration for .zshrc:

```console
$ stow zsh
```

## Zsh
Install oh-my-zsh
https://ohmyz.sh/#install

```console
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### powerlevel10k
```console
brew install powerlevel10k
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
```

## Yazi
Install theme for Yazi
```console
ya pack -a BennyOe/tokyo-night
```

## Python
