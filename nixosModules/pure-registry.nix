{
  lib,
  inputs,
  kasumi,
  nixpkgs,
  ...
}:
{
  imports = [ (nixpkgs + "/nixos/modules/misc/nixpkgs/read-only.nix") ];

  nix = {
    settings.flake-registry = "";
    channel.enable = false;
    registry = kasumi.lib.mbindAttrs (
      n: flake: if flake ? outputs then kasumi.lib.singletonPair n { inherit flake; } else [ ]
    ) inputs;
    nixPath = lib.mapAttrsToList (n: v: "${n}=${v}") inputs;
  };
}
