{ config, ... }:
{
  environment.etc."nixos/flake.nix".source =
    config.home-manager.users.nadevko.xdg.userDirs.desktop + "/dotfiles/flake.nix";
}
