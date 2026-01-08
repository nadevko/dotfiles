{
  lib,
  pkgs,
  inputs,
  ...
}:
let
  prefix = "gnomeTheme.";
  extensionsPrefix = "${prefix}extensions.";

  userjs = import ./.userjs.nix;
  settings = import ./.settings.nix;
  extensionsSettings = import ./.extension-settings.nix;

  inherit (builtins) mapAttrs;
  inherit (lib) types;
  inherit (lib.attrsets) mapAttrs' nameValuePair filterAttrs;
  inherit (lib.options) mkEnableOption mkPackageOption mkOption;
  inherit (lib.modules) mkIf mkBefore;

  profile =
    { config, ... }:
    let
      cfg = config.themes.gnome;
    in
    {
      options.themes.gnome = {
        enable = mkEnableOption "firefox-gnome-theme";
        package =
          mkPackageOption (inputs.self.packages.${pkgs.stdenv.hostPlatform.system} // pkgs)
            "firefox-gnome-theme"
            {
              extraDescription = ''
                Package with `out` and `userjs` outputs, where `out` provides `userChrome.css` and `userContent.css` in `lib/firefox/chrome` and `userjs` is a `user.js` file.
              '';
            };
        settings = mkSettings settings;
        extensions.settings = mkSettings extensionsSettings;
      };
      config = mkIf cfg.enable {
        settings =
          userjs // mapSettings prefix cfg.settings // mapSettings extensionsPrefix cfg.extensions.settings;
        userChrome = mkBefore ''
          @import "${cfg.package}/lib/firefox/chrome/userChrome.css";
        '';
        userContent = mkBefore ''
          @import "${cfg.package}/lib/firefox/chrome/userContent.css";
        '';
      };
    };

  mkSettings = mapAttrs (
    _: description:
    mkOption {
      default = null;
      example = true;
      type = with types; nullOr bool;
      inherit description;
    }
  );
  mapSettings =
    prefix: settings:
    mapAttrs' (n: v: nameValuePair "${prefix}${n}" v) (filterAttrs (n: v: v != null) settings);
in
{
  options.programs.firefox.profiles = mkOption { type = with types; attrsOf (submodule profile); };
}
