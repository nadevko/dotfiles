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
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
  };
}
