{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    adwsteamgtk
    bottles
    gnome-boxes
    gradia
  ];

  dconf.settings = {
    "be/alexandervanhee/gradia" = {
      exit-method = "copy";
      export-format = "webp";
      overwrite-screenshot = true;
      screenshot-folder = config.xdg.userDirs.pictures + "/shots";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Shift><Control>Print";
      command = pkgs.gradia + "/bin/gradia --screenshot=FULL";
      name = "Take Gradia full screenshot";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      binding = "<Control><Alt>Print";
      command = pkgs.gradia + "/bin/gradia --screenshot";
      name = "Take Gradia interactive screenshot";
    };
    "com/usebottles/bottles" = {
      release-candidate = true;
      startup-view = "page_library";
      steam-proton-support = true;
      update-date = true;
    };
    "io/github/Foldex/AdwSteamGtk" = {
      color-theme-options = "Adwaita";
      hide-whats-new-switch = false;
      library-sidebar-options = "Show";
      login-qr-options = "Show";
      no-rounded-corners-switch = false;
      prefs-beta-support = false;
      window-controls-layout-options = "Adwaita";
      window-controls-options = "Adwaita";
    };
    "org/gnome/Console" = {
      audible-bell = false;
      ignore-scrollback-limit = true;
      theme = "auto";
      visual-bell = true;
    };
    "org/gnome/Geary" = {
      single-key-shortcuts = false;
    };
    "org/gnome/Snapshot" = {
      show-composition-guidelines = false;
    };
    "page/kramo/Cartridges" = {
      bottles-location = config.xdg.dataHome + "/bottles";
      high-quality-images = true;
      sgdb = false;
      steam-location = config.home.homeDirectory + "/.steam/steam";
    };
  };
}
