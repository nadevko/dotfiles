{ inputs, pkgs, ... }:
{
  imports = [ inputs.self.homeModules.agenix ];

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
    spotify
    android-studio
  ];
  home = {
    stateVersion = "25.05";
    username = "nadevko";
    homeDirectory = "/home/nadevko";
  };
}
