{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.file.".face".source =
    (pkgs.fetchGitHubAvatar {
      githubID = "93840073";
      githubAvatarHash = "sha256-wsOCr3rbxTEG9cEXvh7GnpW5Xc+8/VP4ZHsjiItgVVU=";
    }).outPath;
  home.file."${config.xdg.configHome}/gtk-3.0/bookmarks".text = ''
    file://${config.xdg.userDirs.desktop} Стальніца
    file://${config.xdg.userDirs.download} Пампоўкі
    file://${config.xdg.userDirs.documents} Дакументы
  '';

  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/desktop/a11y/applications" = {
      screen-keyboard-enabled = false;
      screen-magnifier-enabled = false;
      screen-reader-enabled = false;
    };
    "org/gnome/desktop/a11y/magnifier" = {
      mag-factor = 2.0;
    };
    "org/gnome/desktop/break-reminders/eyesight" = {
      play-sound = true;
    };
    "org/gnome/desktop/break-reminders/movement" = {
      duration-seconds = mkUint32 300;
      interval-seconds = mkUint32 1800;
      play-sound = true;
    };
    "org/gnome/desktop/input-sources" = {
      mru-sources = [
        (mkTuple [
          "xkb"
          "us"
        ])
      ];
      sources = [
        (mkTuple [
          "xkb"
          "by+latin"
        ])
        (mkTuple [
          "xkb"
          "by+ru"
        ])
      ];
      xkb-options = [
        "terminate:ctrl_alt_bksp"
        "lv3:ralt_switch"
        "compose:ins"
        "grp:caps_toggle"
        "shift:both_capslock"
      ];
    };
    "org/gnome/desktop/interface" = {
      enable-animations = true;
      show-battery-percentage = true;
      toolkit-accessibility = false;
    };
    "org/gnome/desktop/notifications" = {
      show-in-lock-screen = false;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };
    "org/gnome/desktop/privacy" = {
      recent-files-max-age = 30;
      remove-old-temp-files = true;
      remove-old-trash-files = true;
    };
    "org/gnome/desktop/sound" = {
      event-sounds = true;
      theme-name = "__custom";
    };
    "org/gnome/desktop/wm/keybindings" = {
      maximize = [ ];
      switch-applications = [ "<Super>Tab" ];
      switch-applications-backward = [ "<Shift><Super>Tab" ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
      unmaximize = [ ];
    };
    "org/gnome/desktop/wm/preferences" = {
      action-middle-click-titlebar = "none";
    };
    "org/gnome/mutter" = {
      edge-tiling = false;
      workspaces-only-on-primary = false;
    };
    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [ ];
      toggle-tiled-right = [ ];
    };
    "org/gnome/nautilus/icon-view" = {
      default-zoom-level = "medium";
    };
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
    };
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-schedule-automatic = false;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
      home = [ "<Super>d" ];
      www = [ "<Super>b" ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control><Alt>Print";
      command = "frog";
      name = "Frog";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>Return";
      command = "kgx";
      name = "Open terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Super>e";
      command = "${config.programs.vscode.package}/bin/code";
      name = "Open Visual Studio Code";
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };
    "org/gnome/shell" = {
      disable-extension-version-validation = false;
      enabled-extensions = [ "gsconnect@andyholmes.github.io" ];
      favorite-apps = [ ];
    };
    "org/gnome/shell/world-clocks" = {
      locations = [ ];
    };
    # "system/proxy" = {
    #   mode = "manual";
    # };
    "system/proxy/socks" = {
      host = "127.0.0.1";
      port = 1080;
    };
  };
}
