{ pkgs, ... }:
{
  home.packages = with pkgs; [
    atool
    ayugram-desktop
    curlie
    freesmlauncher
    gimp3-with-plugins
    libreoffice-fresh
    qbittorrent
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
