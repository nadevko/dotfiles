# Надэўкіны наладкі

[![НіксАС нестабільная](https://img.shields.io/badge/NixOS-Unstable-5176c2?style=for-the-badge&logo=nixos&logoColor=7db9e3)](https://nixos.org)
[![ГітХаб](https://img.shields.io/github/license/nadevko/dotfiles?style=for-the-badge&color=822422&logo=spdx)](https://github.com/nadevko/dotfiles)
[![Англійская](https://img.shields.io/badge/readme-english-123d7a?style=for-the-badge&logo=markdown&logoColor=eeefff)](README.md)

Асабісты рэпазітар з наладкамі [НіксАСі](https://nixos.org) і
[хом-мэнэджара](https://github.com/nix-community/home-manager).

- [Надэўкіны наладкі](#надэўкіны-наладкі)
  - [Стартуйма](#стартуйма)
  - [Канфігі НіксАС](#канфігі-ніксас)
    - [klinicyst](#klinicyst)
  - [Канфігі хом-мэнэджара](#канфігі-хом-мэнэджара)
    - [nadevko](#nadevko)
  - [Ствараем рэпазітар-люстэрку](#ствараем-рэпазітар-люстэрку)
    - [Структура рэпазітара](#структура-рэпазітара)

## Стартуйма

Дадайце гэты рэпазітар да сістэмы як канал.

```bash
sudo nix-channel --add https://github.com/nadevko/dotfiles dotfiles
```

Імпартуйце налады НіксАСі упадабанага кампутара.

```nix
# /etc/nixos/configuration.nix
{ imports = [ <dotfiles/nixos/${hostname}> ]; };
```

Загрузіце налады хом-мэнаджара упадабанага карыстача.

```nix
# ~/.config/home-manager/home.nix
{ imports = [ <dotfiles/home-manager/${username}> ]; };
```

## Канфігі НіксАС

### klinicyst

## Канфігі хом-мэнэджара

### nadevko

## Ствараем рэпазітар-люстэрку

Склануйце рэпазітар кудысьці, на прыклад у `/dotfiles`, і дадавайце наладкі па
абсалютнаму шляху.

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

### Структура рэпазітара

| Шлях                                                              | Cэнс                                                                                                                           |
| ----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `./nixos/${hostname}.nix`, `./home-manager/${username}.nix`       | Кропкі экспарту налад з рэпазітара. Аднолькавыя файлы з выклікам `./lib/default.nix`                                           |
| `./public/nixos/${hostname}`, `./public/home-manager/${username}` | Захоўвае канфірацыю каталогам з аб’яднаным экспартам праз `default.nix`                                                        |
| `./private`                                                       | Аналаг `./public`. Для прыватных дадзеных, таму  шыфравана або пуста ў люстэрках, але можа мець змест у лакальных копіях       |
| `./lib/nixos/`, `./lib/home-manager/`                             | Выключна бібліятэкі аб'яў опцый з нейтральнымі змаўчальнымі значэннямі. Лагічна групуюцца ў файлы і каталогі                   |
| `./lib/default.nix`                                               | Функцыя выгляду `target: name:`, што вяртаe спіс усіх бібліятэк для `${target}` (nixos, host-manager) і `${name}` (host, user) |
| `./lib/nixos/default.nix`, `./lib/home-manager/default.nix`       | Спісы ўсіх бібліятэк ў каталоге                                                                                                |
