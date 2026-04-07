{ pkgs, ... }:
{
  home.packages = with pkgs; [
    android-studio
    anytype
    atool
    ayugram-desktop
    code-cursor
    curlie
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
