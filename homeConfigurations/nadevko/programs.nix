{ pkgs, ... }:
{
  home.packages = with pkgs; [
    android-studio
    atool
    ayugram-desktop
    code-cursor
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
    direnv = {
      enable = true;
      config.global = {
        disable_stdin = true;
        load_dotenv = true;
      };
      nix-direnv.enable = true;
    };
    ripgrep = {
      enable = true;
      arguments = [ "--smart-case" ];
    };
    ripgrep-all.enable = true;
    jq.enable = true;
    keepassxc.enable = true;
  };
}
