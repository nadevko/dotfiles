# Надэўкіны наладкі

[![NixOS Unstable](https://img.shields.io/badge/NixOS-Unstable-5176c2?style=for-the-badge&logo=nixos&logoColor=7db9e3)](https://nixos.org)
[![GitHub](https://img.shields.io/github/license/nadevko/dotfiles?style=for-the-badge&color=822422&logo=spdx)](https://github.com/nadevko/dotfiles)
[![Англійская](https://img.shields.io/badge/readme-english-123d7a?style=for-the-badge&logo=markdown&logoColor=eeefff)](README.md)

Асабісты рэпазітар з наладкамі [НіксАСі](https://nixos.org) і
[хом-мэнэджара](https://github.com/nix-community/home-manager), створаны з
дапамогай маёй бібліятэкі нікс-выразаў.

- [Надэўкіны наладкі](#надэўкіны-наладкі)
  - [Стартуйма](#стартуйма)
  - [NixOS бібліятэка](#nixos-бібліятэка)
  - [NixOS машыны](#nixos-машыны)
    - [klinicyst](#klinicyst)
  - [home-manager бібліятэка](#home-manager-бібліятэка)
  - [home-manager карыстальнікі](#home-manager-карыстальнікі)
    - [nadevko](#nadevko)

## Стартуйма

Дадайце гэты рэпазітар да сістэмы як канал.

```bash
sudo nix-channel --add https://github.com/nadevko/dotfiles dotfiles
```

Загрузіце канфіг па імені хаста на роўні сістэмы. Некаторыя з опцый, з-за
прыватнасці, можна ўсталяваць толькі ў лакальным канфіге. Падрабязнасці
чытайце ў апісанні усталёўванага канфіга.

```nix
# /etc/nixos/configuration.nix
{ imports = [ <dotfiles/nixos/${hostname}> ]; };
```

Загрузіце налады хом-мэнаджара для вашага карыстача.

```nix
# ~/.config/home-manager/home.nix
{ imports = [ <dotfiles/home-manager/${user}> ]; };
```

## NixOS бібліятэка

## NixOS машыны

### klinicyst

## home-manager бібліятэка

## home-manager карыстальнікі

### nadevko
