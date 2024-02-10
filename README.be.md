# Надэўкіны наладкі

[![НіксАС нестабільная](https://img.shields.io/badge/NixOS-Unstable-5176c2?style=for-the-badge&logo=nixos&logoColor=7db9e3)](https://nixos.org)
[![ГітХаб](https://img.shields.io/github/license/nadevko/dotfiles?style=for-the-badge&color=822422&logo=spdx)](https://github.com/nadevko/dotfiles)
[![На англійскай](https://img.shields.io/badge/readme-english-123d7a?style=for-the-badge&logo=markdown&logoColor=eeefff)](README.md)

Наладкі-чакаладкі для [НіксАСі](https://nixos.org) і
[хом-мэнэджара](https://github.com/nix-community/home-manager)

- [Надэўкіны наладкі](#надэўкіны-наладкі)
  - [Хом мэнэджар](#хом-мэнэджар)
    - [Модулі](#модулі)
      - [vim](#vim)
      - [nano](#nano)
    - [Карыстальнікі](#карыстальнікі)
      - [nadevko](#nadevko)
  - [Нікс](#нікс)
    - [Пакеты](#пакеты)
    - [Дапаможнікі](#дапаможнікі)
  - [Усталёўка](#усталёўка)

## Хом мэнэджар

### Модулі

#### vim

- `programs.vim`
  - `enable` - Каб уключыць праграму
  - `package` - пакет для выкарыстання
  - `plugins`
    - `start` - Спіс убудоў для загрузкі пры запуску
    - `opt` - Спіс убудоў для загрузкі пры выкліку
    - `autoload` - Супастаўленне тыпаў файлаў з убудовамі, якія будуць загружацца пры іх адкрыцці
  - `extraConfig` - Дадатковае змесціва для vimrc
  - `extraGuiConfig` - Дадатковае змесціва для gvimrc

#### nano

- `programs.nano`
  - `enable` - усталяваць праграму?
  - `package` - пакет для выкарыстання
  - `options.<option>` - опцыя з `man 5 nanorc`
    - `true` or any - set
    - `false` - unset
    - `null` -  не ўключаць
  - `bindings` - спіс з набораў прывязак
    - `key` - клавіш
      - `^X` - дзе X лацінская літара або нешта са спісу: "@", "]", "\", "^", "_", "Space"
      - `M-X` - дзе X любы сімвал ASCII, акрамя "[", або слова "Space"
      - `Sh-M-X` - дзе X лацінская літара
      - `FN` - where N лічба ад 1 да 24
      - `Ins` або `Del`
    - `function` - з [home-manager/lib/nano/functions.nix](home-manager/lib/nano/functions.nix)
    - `menu` - з [home-manager/lib/nano/menus.nix](home-manager/lib/nano/menus.nix)
  - `includes` - пакет з сінтаксісам у `share/nano`
  - `extra` - спіс частак nanorc

### Карыстальнікі

#### nadevko

- vim
  - Просты як палка
- nano
  - Прыгажэйшы інтэрфэйс
  - Зручныя спалучэнні клавіш

## Нікс

### Пакеты

- `nanorc` (galenguyer-nanorc) - палепшаныя galenguyer nanorc ад scopatz

### Дапаможнікі

- `mkNanorcBundle` - функцыя-дапаможнік для стварэння пакетаў з nanorc
  - `repo` і `owner` - рэпазітар і яго ўладар на ГітХабе
  - `version` і `hash` - тэг версіі і яе хэш
  - `license` - ліцэнзія

## Усталёўка

1. Дадайце гэты рэпазітар да сістэмы.
   ```bash
   sudo nix-channel --add https://github.com/nadevko/dotfiles dotfiles
   sudo nix-channel --update dotfiles
   ```
2. Імпартуйце упадабаную канфігурацыю.
   - nixos
     ```nix
     { imports = [ <dotfiles/nixos/${імя хаста}> ];
     }
     ```
   - home-manager
     ```nix
     {
       imports = [ <dotfiles/home-manager/${імя карыстача}> ];
     }
     ```
