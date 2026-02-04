{
  lib,
  inputs,
  nixpkgs,
  ...
}:
{
  imports = [ (nixpkgs + "/nixos/modules/misc/nixpkgs/read-only.nix") ];

  nix = {
    settings.flake-registry = "";
    channel.enable = false;
    registry =
      inputs |> lib.filterAttrs (_: v: v ? outputs) |> lib.mapAttrs (_: flake: { inherit flake; });
    nixPath = lib.mapAttrsToList (n: flake: "${n}=${flake}") inputs;
  };
}
