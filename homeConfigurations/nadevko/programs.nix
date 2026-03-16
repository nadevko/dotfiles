{ pkgs, ... }:
{
  home.packages = with pkgs; [
    atool
    ayugram-desktop
    code-cursor
    curlie
    freesmlauncher
    gimp3-with-plugins
    libreoffice-fresh
    qbittorrent
    vencord
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
