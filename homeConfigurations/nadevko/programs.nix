{ pkgs, ... }:
{
  home.packages = with pkgs; [
    atool
    ayugram-desktop
    curlie
    gimp3-with-plugins
    libreoffice-fresh
    obsidian
    qbittorrent
    freesmlauncher
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
