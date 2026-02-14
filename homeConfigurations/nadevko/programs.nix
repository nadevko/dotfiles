{ pkgs, ... }:
{
  home.packages = with pkgs; [
    android-studio
    atool
    ayugram-desktop
    curlie
    gimp3-with-plugins
    libreoffice-fresh
    pandoc
    qbittorrent
    rmlint
    staruml
    zotero
  ];

  programs = {
    ripgrep = {
      enable = true;
      arguments = [ "--smart-case" ];
    };
    ripgrep-all.enable = true;
    jq.enable = true;
    keepassxc.enable = true;
  };
}
