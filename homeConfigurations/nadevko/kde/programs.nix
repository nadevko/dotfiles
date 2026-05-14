{ pkgs, ... }:
{
  home.packages = with pkgs; [
    haruna
    kdePackages.isoimagewriter
    kdePackages.kcharselect
    kdePackages.kdenlive
    kdePackages.kdeplasma-addons
    kdePackages.konversation
    kdePackages.ktorrent
    # kdePackages.neochat # 'olm-3.2.16' is marked as insecure
    kdePackages.tokodon
    krita
    libreoffice-qt-fresh
    yt-dlp
  ];
}
