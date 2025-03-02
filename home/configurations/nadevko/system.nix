{ pkgs, ... }:
{
  home.packages = with pkgs; [
    atool
    ayugram-desktop
    libreoffice-fresh
    # nexusmods-app-unfree
    obsidian
    pandoc
    rmlint
    zotero
  ];
  home = {
    stateVersion = "25.05";
    username = "nadevko";
    homeDirectory = "/home/nadevko";
  };
}
