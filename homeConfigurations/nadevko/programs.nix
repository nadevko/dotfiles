{ pkgs, ... }:
{
  home.packages = with pkgs; [
    android-studio
    anytype
    (bottles.override { removeWarningPopup = true; })
    code-cursor
    curlie
    freesmlauncher
    ouch-rar
    telegram-desktop
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
