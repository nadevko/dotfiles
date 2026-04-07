{ pkgs, ... }:
{
  home.packages = with pkgs; [
    haruna
    kdePackages.isoimagewriter
    kdePackages.kcharselect
    kdePackages.kcolorchooser
    kdePackages.kdenlive
    kdePackages.konversation
    kdePackages.ktorrent
    # kdePackages.neochat # 'olm-3.2.16' is marked as insecure
    kdePackages.tokodon
    krita
    libreoffice-qt-fresh
  ];
}
