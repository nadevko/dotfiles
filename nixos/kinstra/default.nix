{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ] ++ (lib.attrValues (import ../.. { inherit pkgs; }).modules);

  nixpkgs = {
    reposPath = ../../modules/nixpkgs/repos.nix;
    repos = {
      nadevko = true;
      nur = true;
    };
  };
}
