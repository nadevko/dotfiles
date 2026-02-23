{ pkgs, ... }:
{
  home.packages = with pkgs; [ twitter-color-emoji ];
  home.pointerCursor = {
    package = pkgs.google-cursor;
    name = "GoogleDot-Blue";
    size = 32;
    gtk.enable = true;
    x11.enable = true;
    dotIcons.enable = true;
  };
  gtk = {
    enable = true;
    iconTheme = {
      name = "MoreWaita";
      package = pkgs.morewaita-icon-theme;
    };
    gtk3.theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
  };
  fonts.fontconfig.defaultFonts = {
    serif = [ "Noto Serif" ];
    sansSerif = [ "Adwaita Sans" ];
    monospace = [ "Adwaita Mono" ];
    emoji = [ "Twitter Color Emoji " ];
  };
  # xdg.configFile = {
  #   "Kvantum/${pkgs.adwaita-kvantum.passthru.themeName}".source =
  #     "${pkgs.adwaita-kvantum}/share/Kvantum/${pkgs.adwaita-kvantum.passthru.themeName}";
  #   "Kvantum/kvantum.kvconfig".text = lib.generators.toINI { } {
  #     General.theme = pkgs.adwaita-kvantum.passthru.themeName;
  #   };
  # };
}
