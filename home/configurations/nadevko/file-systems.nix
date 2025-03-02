{ config, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;

  userDir = directory: "${config.home.homeDirectory}/${directory}";
  homeDir = directory: userDir ".local/${directory}";
in
{
  xdg = {
    enable = true;
    mime.enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = userDir "Workspace";
      documents = userDir "Papers";
      download = userDir "Downloaded";
      music = userDir "Music";
      pictures = userDir "Images";
      publicShare = userDir "Shared";
      templates = userDir "Templates";
      videos = userDir "Videos";
      extraConfig.XDG_R9K_DIR = userDir "R9K";
      extraConfig.XDG_SECRETS_DIR = homeDir "secrets";
    };
    cacheHome = homeDir "cache";
    configHome = homeDir "config";
    dataHome = homeDir "data";
    stateHome = homeDir "state";
  };

  home = {
    preferXdgDirectories = true;
    file = {
      ".cache".source = mkOutOfStoreSymlink config.xdg.cacheHome;
      ".config".source = mkOutOfStoreSymlink config.xdg.configHome;
      ".local/share".source = mkOutOfStoreSymlink config.xdg.dataHome;
      ".ssh".source = mkOutOfStoreSymlink "${config.xdg.userDirs.extraConfig.XDG_SECRETS_DIR}/ssh";
    };
  };
}
