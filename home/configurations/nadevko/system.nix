{ inputs, pkgs, ... }:
let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
in
{
  home.packages =
    with pkgs;
    with inputs.self.packages.${pkgs.system};
    [
      atool
      ayugram-desktop
      gimp3-with-plugins
      libreoffice-fresh
      # nexusmods-app-unfree
      unstable-pkgs.obsidian
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
  assertions = [
    {
      message = "Now unstable can be removed";
      assertion = builtins.compareVersions pkgs.obsidian.version "1.9" == -1;
    }
  ];
}
