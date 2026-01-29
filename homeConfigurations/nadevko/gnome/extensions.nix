{
  config,
  pkgs,
  lib,
  ...
}:
let
  burn-my-windows-profile = "${config.xdg.configHome}/burn-my-windows/profiles/1755716169589037.conf";
in
{
  imports = [ ../../../homeModules/gnome.nix ];

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
        settings."org/gnome/shell/extensions/appindicator" = {
          icon-brightness = 0.0;
          icon-contrast = 0.0;
          icon-opacity = 240;
          icon-saturation = 0.0;
          icon-size = 0;
        };
      }
      {
        package = bilingual-app-search;
        id = "bilingual-app-search@pwa.lu";
      }
      {
        package = luminus-desktop.overrideAttrs (_: {
          postInstall = ''
            substituteInPlace $out/share/gnome-shell/extensions/luminus-desktop@dikasp.gitlab/stylesheet-light.css \
              --replace "#f0f0f0" "#fafafb"
            echo "#panel { background-color: #222226; }" > $out/share/gnome-shell/extensions/luminus-desktop@dikasp.gitlab/stylesheet-dark.css
          '';
        });
        id = "luminus-desktop@dikasp.gitlab";
      }
      {
        package = auto-accent-colour;
        id = "auto-accent-colour@Wartybix";
      }
      {
        package = burn-my-windows;
        id = "burn-my-windows@schneegans.github.com";
        settings."org/gnome/shell/extensions/burn-my-windows" = {
          active-profile = burn-my-windows-profile;
          preview-effect = "";
        };
      }
      {
        package = color-picker;
        id = "color-picker@tuberry";
        settings."org/gnome/shell/extensions/color-picker" = with lib.hm.gvariant; {
          default-format = mkUint32 0;
          enable-notify = true;
          enable-shortcut = true;
          enable-sound = false;
          enable-systray = false;
          color-picker-shortcut = [ "<Alt>0" ];
          notify-sound = mkUint32 0;
          notify-style = mkUint32 1;
          persistent-mode = false;
          preview-style = mkUint32 0;
        };
      }
      {
        package = removable-drive-menu;
        id = "drive-menu@gnome-shell-extensions.gcampax.github.com";
      }
      {
        package = mpris-label;
        id = "mprisLabel@moon-0xff.github.com";
        settings."org/gnome/shell/extensions/mpris-label" = {
          auto-switch-to-most-recent = true;
          button-placeholder = "MPRIS player";
          enable-double-clicks = true;
          extension-place = "left";
          show-icon = "left";
          symbolic-source-icon = true;
          use-album = true;
        };
      }
      {
        package = pip-on-top;
        id = "pip-on-top@rafostar.github.com";
        settings."org/gnome/shell/extensions/pip-on-top" = {
          stick = true;
        };
      }
      {
        package = places-status-indicator;
        id = "places-menu@gnome-shell-extensions.gcampax.github.com";
      }
      {
        package = tiling-shell;
        id = "tilingshell@ferrarodomenico.com";
        settings."org/gnome/shell/extensions/tilingshell" = {
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
      }
      {
        package = vscode-search-provider;
        id = "vscode-search-provider@mrmarble.github.com";
      }
      {
        package = wsp-windows-search-provider;
        id = "windows-search-provider@G-dH.github.com";
        settings."org/gnome/shell/extensions/windows-search-provider" = {
          custom-prefixes = ";";
          dash-icon-position = 0;
          highlighting-style = 0;
          search-commands = true;
          search-method = 1;
        };
      }
      {
        package = task-widget;
        id = "task-widget@juozasmiskinis.gitlab.io";
        settings."org/gnome/shell/extensions/task-widget" = {
          group-past-tasks = true;
          hct-apotac-unit = 2;
          hct-apotac-value = 2;
          hide-completed-tasks = 2;
          hide-empty-completed-task-lists = true;
          hide-header-for-singular-task-lists = true;
          merge-task-lists = false;
          show-only-selected-categories = false;
        };
      }
    ];
  };
}
