{ pkgs, ... }:
{
  imports = [ ../../homeModules/agenix.nix ];

  home.packages = with pkgs; [
    atool
    ayugram-desktop
    gimp3-with-plugins
    libreoffice-fresh
    # nexusmods-app-unfree
    pandoc
    qbittorrent
    rmlint
    staruml
    zotero
    android-studio
  ];
  home = {
    stateVersion = "25.05";
    username = "nadevko";
    homeDirectory = "/home/nadevko";
  };
}
