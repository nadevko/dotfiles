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
  - [Хом мэнэджар](#хом-мэнэджар)
    - [Модулі](#модулі)
      - [vim](#vim)
      - [nano](#nano)
    - [Карыстальнікі](#карыстальнікі)
      - [nadevko](#nadevko)
  - [Усталёўка](#усталёўка)

## Структура рэпазітара

### Файлавая сістэма

- `/nixos/`, `/home-manager/` - файлы канфігурацыі НіксАСі і хом-мэнэджара адпаведна
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

## Хом мэнэджар

### Модулі

#### vim

- `programs.vim`
  - `enable` - Каб уключыць праграму
  - `package` - Пакет для выкарыстання
  - `plugins`
    - `start` - Спіс убудоў для загрузкі пры запуску
    - `opt` - Спіс убудоў для загрузкі пры выкліку
    - `autoload` - Супастаўленне тыпаў файлаў з убудовамі, якія будуць загружацца пры іх адкрыцці
  - `extraConfig` - Дадатковае змесціва для vimrc
  - `extraGuiConfig` - Дадатковае змесціва для gvimrc

#### nano

- `programs.nano`
  - `enable` - Каб уключыць праграму
  - `package` - Пакет для выкарыстання
  - `config` - Набор з усіх опцый Nano (`man 5 nanorc`)
    - Калі сцяг
      - `true` - Уключыць
      - `false` - Адключыць
      - `null` - Без зменаў
    - Інакш - гэта шлях/лічба/колер/радок або `null` (для змаўчальных)
  - `bindings` - Клавіша для выканання функцыі ў меню. `unbind` каб нічога не рабіць
    - `[{ key, function, menu }]`
  - `includes` - Спіс пакетаў з nanorc ў каталогах `share/nano` і `share/nano/extra`
  - `extraConfig` - Дадатковае змесціва для nanorc

### Карыстальнікі

#### nadevko

- vim
  - Просты як палка
- nano
  - Прыгажэйшы інтэрфэйс
  - Зручныя спалучэнні клавіш

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
