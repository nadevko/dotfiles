# Надэўкіны наладкі

[![НіксАС нестабільная](https://img.shields.io/badge/NixOS-Unstable-5176c2?style=for-the-badge&logo=nixos&logoColor=7db9e3)](https://nixos.org)
[![ГітХаб](https://img.shields.io/github/license/nadevko/dotfiles?style=for-the-badge&color=822422&logo=spdx)](https://github.com/nadevko/dotfiles)
[![На англійскай](https://img.shields.io/badge/readme-english-123d7a?style=for-the-badge&logo=markdown&logoColor=eeefff)](README.md)

Наладкі-чакаладкі для [НіксАСі](https://nixos.org) і
[хом-мэнэджара](https://github.com/nix-community/home-manager)

- [Надэўкіны наладкі](#надэўкіны-наладкі)
  - [Структура рэпазітара](#структура-рэпазітара)
    - [Файлавая сістэма](#файлавая-сістэма)
    - [Галіны версіявання](#галіны-версіявання)
  - [Канфігі НіксАС](#канфігі-ніксас)
    - [klinicyst](#klinicyst)
  - [Канфігі хом-мэнэджара](#канфігі-хом-мэнэджара)
    - [nadevko](#nadevko)
  - [Усталёўка](#усталёўка)

## Структура рэпазітара

### Файлавая сістэма

- `./nixos/`, `./home-manager/` - файлы канфігурацыі НіксАСі і хом-мэнэджара адпаведна
  - `default.nix` - змяшчае функцыю, што:
    Прымае `${імя}`
    Вяртае спіс `lib/default.nix` аб’яднаны з `${імя}/default.nix`
  - `lib/` - змяшчае агульныя файлы аб’яў опцый
    - `default.nix` - спіс усіх бібліятэк, парадак падлучэння
  - `${імя}/` - каталог канфігаў імя
    - `default.nix` - спіс усіх бібліятэк, парадак падлучэння

### Галіны версіявання

- `master` - галоўная публічная галіна распрацоўкі, замест прыватных дадзеных каментары або пустыя файлы
- `personal` - залежная, дададзены прыватныя значэнні

## Канфігі НіксАС

### klinicyst

## Канфігі хом-мэнэджара

### nadevko

## Усталёўка

1. Дадайце гэты рэпазітар да сістэмы.
   ```bash
   sudo nix-channel --add https://github.com/nadevko/dotfiles dotfiles
   sudo nix-channel --update dotfiles
   ```
2. Імпартуйце упадабаную канфігурацыю.
   - nixos
     ```nix
     {
       imports = (import <dotfiles/nixos> ${імя хаста});
     }
     ```
   - home-manager
     ```nix
     {
       imports = (import <dotfiles/home-manager> ${імя карыстача});
     }
     ```
