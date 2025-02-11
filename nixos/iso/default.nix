{
  pkgs,
  lib,
  ...
}:
let
  maintainer = import ../.. { inherit pkgs; };
in
{
  _class = "nixos";

  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ] ++ lib.attrValues maintainer.modules;

  config = {
    nixpkgs.overlays = lib.attrValues maintainer.overlays;
    environment.systemPackages = [
      # pkgs.nur.repos.mic92.hello-nur
    ];
  };
}
