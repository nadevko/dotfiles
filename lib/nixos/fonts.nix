{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    corefonts
    vistafonts
    ubuntu_font_family
    nerdfonts
  ];
  nixpkgs.unfree.packages = [ "corefonts" "vista-fonts" ];
}
