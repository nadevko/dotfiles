# Nadeŭka's dotfiles

[![NixOS Unstable](https://img.shields.io/badge/NixOS-Unstable-5176c2?style=for-the-badge&logo=nixos&logoColor=7db9e3)](https://nixos.org)
[![GitHub](https://img.shields.io/github/license/nadevko/dotfiles?style=for-the-badge&color=822422&logo=spdx)](https://github.com/nadevko/dotfiles)
[![Англійская](https://img.shields.io/badge/readme-на_беларускай-de0101?style=for-the-badge&logo=markdown&logoColor=eeefff)](README.be.md)

Personal dotfiles setup for [NixOS](https://nixos.org) and
[home-manager](https://github.com/nix-community/home-manager), created with
my own nix-expressions libraries.

- [Nadeŭka's dotfiles](#nadeŭkas-dotfiles)
  - [Quick start](#quick-start)
  - [NixOS library](#nixos-library)
  - [NixOS hosts](#nixos-hosts)
    - [klinicyst](#klinicyst)
  - [home-manager library](#home-manager-library)
  - [home-manager users](#home-manager-users)
    - [nadevko](#nadevko)

## Quick start

Add this repo to your system as a channel.

```bash
sudo nix-channel --add https://github.com/nadevko/dotfiles dotfiles
```

Load config for needed hostname at system level. Some required options, for
privacy reason, can be setted only in local configs. Read the details in the
description of the installed config.

```nix
# /etc/nixos/configuration.nix
{ imports = [ <dotfiles/nixos/${hostname}> ]; };
```

Load home-manager-setup for your user.

```nix
# ~/.config/home-manager/home.nix
{ imports = [ <dotfiles/home-manager/${user}> ]; };
```

## NixOS library

## NixOS hosts

### klinicyst

## home-manager library

## home-manager users

### nadevko
