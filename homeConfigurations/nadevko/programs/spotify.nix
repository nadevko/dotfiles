{ inputs, pkgs, ... }:
let
  inherit (inputs) spicetify-nix;
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [ spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      betterGenres
      keyboardShortcut
      lastfm
      shuffle
      songStats
      wikify
    ];
    enabledCustomApps = with spicePkgs.apps; [ localFiles ];
    theme = spicePkgs.themes.default;
  };
}
