{
  pkgs,
  ...
}:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ] ++ (import ../.. { inherit pkgs; }).modules.all;

  nixpkgs = {
    reposPath = ../../modules/nixpkgs/repos.nix;
    repos = {
      nadevko = true;
      nur = true;
    };
  };
}
