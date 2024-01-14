# Nadeŭka's dotfiles

[![NixOS Unstable](https://img.shields.io/badge/NixOS-Unstable-5176c2?style=for-the-badge&logo=nixos&logoColor=7db9e3)](https://nixos.org)
[![GitHub](https://img.shields.io/github/license/nadevko/dotfiles?style=for-the-badge&color=822422&logo=spdx)](https://github.com/nadevko/dotfiles)
[![Belarusian](https://img.shields.io/badge/readme-на_беларускай-de0101?style=for-the-badge&logo=markdown&logoColor=eeefff)](README.be.md)

Personal repository for [NixOS](https://nixos.org)
[home-manager](https://github.com/nix-community/home-manager) configurations.

- [Nadeŭka's dotfiles](#nadeŭkas-dotfiles)
  - [Quick start](#quick-start)
  - [NixOS configs](#nixos-configs)
    - [klinicyst](#klinicyst)
  - [home-manager configs](#home-manager-configs)
    - [nadevko](#nadevko)
  - [Create repository mirror](#create-repository-mirror)
    - [Repository structure](#repository-structure)

## Quick start

Add this repo to your system as a channel.

```bash
sudo nix-channel --add https://github.com/nadevko/dotfiles dotfiles
```

Import NixOS config for liked host.

```nix
# /etc/nixos/configuration.nix
{ imports = [ <dotfiles/nixos/${hostname}> ]; };
```

Load home-manager setting for liked user.

```nix
# ~/.config/home-manager/home.nix
{ imports = [ <dotfiles/home-manager/${username}> ]; };
```

## NixOS configs

### klinicyst

## home-manager configs

### nadevko

## Create repository mirror

Clone repo somewhere, `/dotfiles` for example, and use configs via absolute
path.

```bash
git clone https://github.com/nadevko/dotfiles /dotfiles
```

```nix
# /etc/nixos/configuration.nix
{ imports = [ /dotfiles/nixos/${hostname} ]; };
```

```nix
# ~/.config/home-manager/home.nix
{ imports = [ /dotfiles/home-manager/${username} ]; };
```

### Repository structure

| Path                                                              | Meaning                                                                                                                       |
| ----------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `./nixos/${hostname}.nix`, `./home-manager/${username}.nix`       | Export points in repository. The same files with `./lib/default.nix` call                                                     |
| `./public/nixos/${hostname}`, `./public/home-manager/${username}` | Saves the configuration as a directory with a combined export via `default.nix`                                               |
| `./private`                                                       | Analogous to `./public`. For private data, so encrypted or empty in mirrors, but may contain content in local copies          |
| `./lib/nixos/`, `./lib/home-manager/`                             | Only option declaration libraries with neutral default values. Logically grouped into files and directories                   |
| `./lib/default.nix`                                               | A `target: name:` function that returns list of all libraries to `${target}` (nixos, home-manager) and `${name}` (host, user) |
| `./lib/nixos/default.nix`, `./lib/home-manager/default.nix`       | Lists all libraries in the directory                                                                                          |
