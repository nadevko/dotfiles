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
      - [vim](#vim)
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

#### vim

- `programs.vim`
  - `enable` - To enable program
  - `package` - Package to use
  - `plugins`
    - `start` - List of plugins to load at startup
    - `opt` - List of plugins to load at call
    - `autoload` - Mapping filetypes to plugins that will be loaded when they are opened
  - `extraConfig` - Extra contents for vimrc
  - `extraGuiConfig` - Extra contents for gvimrc

#### nano

- `programs.nano`
  - `enable` - To enable program
  - `package` - Package to use
  - `config` - Set from all nano's options (`man 5 nanorc`)
    - If is a flag
      - `true` - Enable
      - `false` - Disable
      - `null` - Without changes
    - Else is a path/number/color/row or `null` (to defaults)
  - `bindings` - Set key to do function in the menu. 'unbind' to do nothing
    - `[{ key, function, menu }]`
  - `includes` - List of packages with nanorcs in `share/nano` and `share/nano/extra` dirs
  - `extraConfig` - Extra contents for nanorc

### Users

#### nadevko

- vim
  - simple as can
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
