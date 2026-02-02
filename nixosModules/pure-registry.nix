{ lib, inputs, ... }:
{
  imports = [ (inputs.nixpkgs + "/nixos/modules/misc/nixpkgs/read-only.nix") ];

  nix = {
    settings.flake-registry = "";
    channel.enable = false;
    registry = lib.mapAttrs (_: flake: { inherit flake; }) (lib.filterAttrs (_: v: v ? outputs) inputs);
    nixPath = lib.mapAttrsToList (n: flake: "${n}=${flake}") inputs;
  };
}
