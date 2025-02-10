{
  pkgs,
  lib,
  ...
}:
{
  _class = "nixos";

  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ] ++ lib.attrValues (import ../.. { inherit pkgs; }).modules;

  config = {
    environment.systemPackages = [
      pkgs.nur.repos.mic92.hello-nur
    ];
  };
}
