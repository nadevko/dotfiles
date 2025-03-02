{ inputs, pkgs, ... }:
{
  home.packages =
    with pkgs;
    with nerd-fonts;
    [
      corefonts
      inputs.self.packages.${system}.gost-fonts
      liberation_ttf
      _0xproto
      mononoki
      ubuntu
      victor-mono
      space-mono
      vistafonts
      noto-fonts-lgc-plus
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
    ];
  fonts.fontconfig.enable = true;
}
