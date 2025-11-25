{ inputs, pkgs, ... }:
{
  imports = [ inputs.self.homeModules.agenix ];

  home.packages =
    with pkgs;
    with inputs.self.packages.${pkgs.system};
    [
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
    ];
  home = {
    stateVersion = "25.05";
    username = "nadevko";
    homeDirectory = "/home/nadevko";
  };
}
