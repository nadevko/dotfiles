# Nadeŭka's dotfiles

[![NixOS Unstable](https://img.shields.io/badge/NixOS-Unstable-5176c2?style=for-the-badge&logo=nixos&logoColor=7db9e3)](https://nixos.org)
[![GitHub](https://img.shields.io/github/license/nadevko/dotfiles?style=for-the-badge&color=822422&logo=spdx)](https://github.com/nadevko/dotfiles)
[![in Belarusian](https://img.shields.io/badge/readme-на_беларускай-de0101?style=for-the-badge&logo=markdown&logoColor=eeefff)](README.be.md)

Personal repository for [NixOS](https://nixos.org)
[home-manager](https://github.com/nix-community/home-manager) configurations

- [Nadeŭka's dotfiles](#nadeŭkas-dotfiles)
  - [home-manager](#home-manager)
    - [Modules](#modules)
      - [vim](#vim)
      - [nano](#nano)
    - [Users](#users)
      - [nadevko](#nadevko)
  - [Nix](#nix)
    - [Packages](#packages)
    - [Helpers](#helpers)
  - [Installation](#installation)

## home-manager

### Modules

#### vim

- `programs.vim`
  - `enable` - install program?
  - `package` - package to install
  - `vimrc`
    - `plugins`
      - `start`
      - `optional`
      - `autoload`
    - `extra`
  - `gvimrc`
    - `extra`
  - `plugins`
    - `start` - List of plugins to load at startup
    - `opt` - List of plugins to load at call
    - `autoload` - Mapping filetypes to plugins that will be loaded when they are opened

#### nano

- `programs.nano`
  - `enable` - install program?
  - `package` - package to install
  - `options.<option>` - option from `man 5 nanorc`
    - `true` або іншае - set
    - `false` - unset
    - `null` -  do not include
  - `bindings` - list of keybindings sets
    - `key`
      - `^X` - where X is a Latin letter, or one of several ASCII characters (@, ], \, ^, _), or the word "Space"
      - `M-X` - where X is any ASCII character except [, or the word "Space"
      - `Sh-M-X` - where X is a Latin letter
      - `FN` - where N is a numeric value from 1 to 24
      - `Ins` or `Del`
    - `function` - from [home-manager/lib/nano/functions.nix](home-manager/lib/nano/functions.nix)
    - `menu` - from [home-manager/lib/nano/menus.nix](home-manager/lib/nano/menus.nix)
  - `includes` - packages with nano syntax in `share/nano`
  - `extra` - list of parts of nanorc

### Users

#### nadevko

- vim
  - simple as can
- nano
  - simpler ui
  - handy classic keybindings

## Nix

### Packages

- `nanorc` (galenguyer-nanorc) - improved by galenguyer scopatz nanorc

### Helpers

- `mkNanorcBundle` - helper to create packages of nanorc
  - `repo` and `owner` - repository and its owner on GitHub
  - `version` and `hash` - version tag and its hash
  - `license` - one from lib.licenses

## Installation

1. Add this repository to your system
   ```bash
   sudo nix-channel --add https://github.com/nadevko/dotfiles dotfiles
   sudo nix-channel --update dotfiles
   ```
2. Import your liked configuration
   - nixos
     ```nix
     { imports = [ <dotfiles/nixos/${name of host}> ]; }
     ```
   - home-manager
     ```nix
     { imports = [ <dotfiles/home-manager/${name of user}> ]; }
     ```
