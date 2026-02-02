{
  lib,
  pkgs,
  kasumi-lib,
  ...
}:
let
  inherit (builtins) mapAttrs;
  inherit (lib) types;
  inherit (lib.attrsets) mapAttrs' nameValuePair filterAttrs;
  inherit (lib.options) mkEnableOption mkPackageOption mkOption;
  inherit (lib.modules) mkIf mkBefore;
  inherit (kasumi-lib.trivial) neq;

  profile =
    { config, ... }:
    let
      cfg = config.themes.gnome;

      mapSettings = mapAttrs (
        _: description:
        mkOption {
          default = null;
          example = true;
          type = with types; nullOr bool;
          inherit description;
        }
      );

      mkSettings =
        prefix: settings:
        settings |> filterAttrs (_: neq null) |> mapAttrs' (n: v: nameValuePair (prefix + n) v);
    in
    {
      options.themes.gnome = {
        enable = mkEnableOption "firefox-gnome-theme";
        package = mkPackageOption pkgs "firefox-gnome-theme" {
          extraDescription = ''
            Package with `out` and `userjs` outputs, where `out` provides `userChrome.css` and `userContent.css` in `lib/firefox/chrome` and `userjs` is a `user.js` file.
          '';
        };
        settings = mapSettings <| import ./.settings.nix;
        extensions.settings = mapSettings <| import ./.extension-settings.nix;
      };
      config = mkIf cfg.enable {
        settings =
          import ./.userjs.nix
          // mkSettings "gnomeTheme." cfg.settings
          // mkSettings "gnomeTheme.extensions." cfg.extensions.settings;
        userChrome = mkBefore ''
          @import "${cfg.package}/lib/firefox/chrome/userChrome.css";
        '';
        userContent = mkBefore ''
          @import "${cfg.package}/lib/firefox/chrome/userContent.css";
        '';
      };
    };
in
{
  options.programs.firefox.profiles = mkOption { type = with types; attrsOf <| submodule profile; };
}
