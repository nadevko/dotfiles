{ pkgs, spicetify-nix, ... }:
{
  imports = [ spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;
    enabledExtensions = with pkgs.spicePkgs.extensions; [
      adblockify
      betterGenres
      keyboardShortcut
      lastfm
      shuffle
      songStats
      wikify
    ];
    enabledCustomApps = with pkgs.spicePkgs.apps; [ localFiles ];
    theme = pkgs.spicePkgs.themes.default;
  };
}
