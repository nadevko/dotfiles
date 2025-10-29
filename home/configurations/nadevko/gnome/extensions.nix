{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  burn-my-windows-profile = "${config.xdg.configHome}/burn-my-windows/profiles/1755716169589037.conf";
in
{
  imports = [ inputs.self.homeModules.gnome ];
  home.file.${burn-my-windows-profile}.text = lib.generators.toINI { } {
    burn-my-windows-profile = {
      tv-glitch-enable-effect = true;
      fire-enable-effect = false;
      tv-enable-effect = false;
      tv-glitch-color = "rgb(95,45,91)";
      tv-glitch-animation-time = 250;
      tv-glitch-strength = 4.0;
    };
  };
  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      {
        package = accent-directories;
        id = "accent-directories@taiwbi.com";
      }
      {
        package = appindicator;
        id = "appindicatorsupport@rgcjonas.gmail.com";
        settings = {
          "org/gnome/shell/extensions/appindicator" = {
            icon-brightness = 0.0;
            icon-contrast = 0.0;
            icon-opacity = 240;
            icon-saturation = 0.0;
            icon-size = 0;
          };
        };
      }
      {
        package = bilingual-app-search;
        id = "bilingual-app-search@pwa.lu";
      }
      {
        package = blur-my-shell;
        id = "blur-my-shell@aunetx";
        settings = {
          "org/gnome/shell/extensions/blur-my-shell" = {
            settings-version = 2;
          };
          "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
            brightness = 0.6;
            sigma = 30;
          };
          "org/gnome/shell/extensions/blur-my-shell/coverflow-alt-tab" = {
            pipeline = "pipeline_default";
          };
          "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
            blur = true;
            brightness = 0.6;
            pipeline = "pipeline_default_rounded";
            sigma = 30;
            static-blur = true;
            style-dash-to-dock = 0;
          };
          "org/gnome/shell/extensions/blur-my-shell/lockscreen" = {
            pipeline = "pipeline_default";
          };
          "org/gnome/shell/extensions/blur-my-shell/overview" = {
            pipeline = "pipeline_default";
          };
          "org/gnome/shell/extensions/blur-my-shell/panel" = {
            brightness = 0.6;
            pipeline = "pipeline_default";
            sigma = 30;
          };
          "org/gnome/shell/extensions/blur-my-shell/screenshot" = {
            pipeline = "pipeline_default";
          };
          "org/gnome/shell/extensions/blur-my-shell/window-list" = {
            brightness = 0.6;
            sigma = 30;
          };
        };
      }
      {
        package = burn-my-windows;
        id = "burn-my-windows@schneegans.github.com";
        settings = {
          "org/gnome/shell/extensions/burn-my-windows" = {
            active-profile = burn-my-windows-profile;
            preview-effect = "";
          };
        };
      }
      {
        package = color-picker;
        id = "color-picker@tuberry";
        settings = with lib.hm.gvariant; {
          "org/gnome/shell/extensions/color-picker" = {
            default-format = mkUint32 0;
            enable-notify = true;
            enable-shortcut = true;
            enable-sound = false;
            enable-systray = false;
            notify-sound = mkUint32 0;
            notify-style = mkUint32 1;
            persistent-mode = false;
            preview-style = mkUint32 0;
          };
        };
      }
      {
        package = removable-drive-menu;
        id = "drive-menu@gnome-shell-extensions.gcampax.github.com";
      }
      {
        package = mpris-label;
        id = "mprisLabel@moon-0xff.github.com";
        settings = {
          "org/gnome/shell/extensions/mpris-label" = {
            auto-switch-to-most-recent = true;
            button-placeholder = "MPRIS player";
            enable-double-clicks = true;
            extension-place = "left";
            show-icon = "left";
            symbolic-source-icon = true;
            use-album = true;
          };
        };
      }
      {
        package = pip-on-top;
        id = "pip-on-top@rafostar.github.com";
        settings = {
          "org/gnome/shell/extensions/pip-on-top" = {
            stick = true;
          };
        };
      }
      {
        package = places-status-indicator;
        id = "places-menu@gnome-shell-extensions.gcampax.github.com";
      }
      {
        package = syncthing-indicator;
        id = "syncthing@gnome.2nv2u.com";
        settings = {
          "org/gnome/shell/extensions/syncthing" = {
            auto-start-item = true;
            icon-state = true;
            menu = 0;
            settings-button = true;
          };
        };
      }
      {
        package = tiling-shell;
        id = "tilingshell@ferrarodomenico.com";
        settings = {
          "org/gnome/shell/extensions/tilingshell" = {
            active-screen-edges = true;
            enable-autotiling = false;
            enable-blur-selected-tilepreview = false;
            enable-blur-snap-assistant = false;
            enable-screen-edges-windows-suggestions = false;
            enable-smart-window-border-radius = true;
            enable-snap-assistant-windows-suggestions = false;
            enable-tiling-system-windows-suggestions = false;
            enable-window-border = false;
            top-edge-maximize = true;
          };
        };
      }
      {
        package = vscode-search-provider;
        id = "vscode-search-provider@mrmarble.github.com";
      }
      {
        package = wsp-windows-search-provider;
        id = "windows-search-provider@G-dH.github.com";
        settings = {
          "org/gnome/shell/extensions/windows-search-provider" = {
            custom-prefixes = ";";
            dash-icon-position = 0;
            highlighting-style = 0;
            search-commands = true;
            search-method = 1;
          };
        };
      }
    ];
  };
}
