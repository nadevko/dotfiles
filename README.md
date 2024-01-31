# Nadeŭka's dotfiles

[![NixOS Unstable](https://img.shields.io/badge/NixOS-Unstable-5176c2?style=for-the-badge&logo=nixos&logoColor=7db9e3)](https://nixos.org)
[![GitHub](https://img.shields.io/github/license/nadevko/dotfiles?style=for-the-badge&color=822422&logo=spdx)](https://github.com/nadevko/dotfiles)
[![in Belarusian](https://img.shields.io/badge/readme-на_беларускай-de0101?style=for-the-badge&logo=markdown&logoColor=eeefff)](README.be.md)

Personal repository for [NixOS](https://nixos.org)
[home-manager](https://github.com/nix-community/home-manager) configurations

- [Nadeŭka's dotfiles](#nadeŭkas-dotfiles)
  - [Structure of the repository](#structure-of-the-repository)
    - [File system](#file-system)
    - [Branches of versioning](#branches-of-versioning)
  - [home-manager](#home-manager)
    - [Modules](#modules)
      - [nano](#nano)
    - [Users](#users)
      - [nadevko](#nadevko)
  - [Installation](#installation)

## Structure of the repository

### File system

- `/nixos/`, `/home-manager/` - NixOS and home-manager configuration files, respectively
  - `default.nix` - contains function that:
    Accepts `${name}`
    Returns `lib/default.nix` list in merge with `${name}/default.nix`
  - `lib/` - contains common option declaration files
    - `default.nix` - list of all libraries, order of connection
  - `${name}/` - config directory of name
    - `default.nix` - list of all libraries, order of connection

### Branches of versioning

- `master` - main public development branch, instead of private data comments or empty files
- `personal` - dependent, private values ​​added

## home-manager

### Modules

#### nano

- `programs.nano`
  - `enable` - to enable program
  - `config` - set from all nano's options (`man 5 nanorc`)
    - if is a flag
      - `true` - enable
      - `false` - disable
      - `null` - without changes
    - else is a path/number/color/row or `null` (to defaults)
  - `bindings` - list of key bindings
    - `[{ key, function, menu }]` - set `key` to do `function` in a `menu`
  - `includes` - packages with nanorc files in a `share/nano` and
    `share/nano/extra` dirs
  - `extraConfig` - rows to add at the end of nano's configuration

### Users

#### nadevko

- nano
  - simpler ui
  - handy classic keybindings

## Installation

1. Add this repository to your system
   ```bash
   sudo nix-channel --add https://github.com/nadevko/dotfiles dotfiles
   sudo nix-channel --update dotfiles
   ```
2. Import your liked configuration
   - nixos
     ```nix
     {
       imports = (import <dotfiles/nixos> ${name of host});
     }
     ```
   - home-manager
     ```nix
     {
       imports = (import <dotfiles/home-manager> ${name of user});
     }
     ```
