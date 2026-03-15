{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages =
    with pkgs;
    with nerd-fonts;
    [
      _0xproto
      corefonts
      gost-fonts
      liberation_ttf
      mononoki
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      noto-fonts-lgc-plus
      space-mono
      ubuntu
      victor-mono
      vista-fonts
      xits-math
    ];
}
