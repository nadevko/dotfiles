{ pkgs, ... }:
{
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
  };
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      name = "Adwaita";
      package = pkgs.adwaita-qt6;
    };
  };
}
