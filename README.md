# dotfiles

Dotfiles for my Arch Linux systems.

## Prerequisites

Install the following:

### Git

```sh
pacman -S git
```

### Stow

```sh
pacman -S stow
```

## Installation

1. Clone this repository to your $HOME directory.

```sh
git clone git@github.com/darkokos/dotfiles.git $HOME
```
2. Use GNU Stow to create symlinks to the dotfiles.

```sh
cd $HOME/dotfiles
stow .
```
