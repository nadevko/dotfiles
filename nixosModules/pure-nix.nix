{
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [
    inputs.agenix.nixosModules.default
    ./pure-registry.nix
  ];

  config.system = {
    disableInstallerTools = true;
    tools.nixos-rebuild.enable = lib.mkDefault true;
  };

  config.age.secrets.tokens-nix = {
    path = "/etc/nix/tokens.conf";
    mode = "0400";
    owner = "root";
  };

  config.nix = {
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"

        "fetch-tree"
        "fetch-closure"
        "pipe-operators"

        "blake3-hashes"
        "git-hashing"
        "no-url-literals"

        "auto-allocate-uids"
        "dynamic-derivations"
        "cgroups"
        "parse-toml-timestamps"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://nadevko.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nadevko.cachix.org-1:fmf8N0u8U9RbHYvqw0hP+akk2/tQ8rdm1SWsCogX4tU="
      ];

      trusted-users = [ "@wheel" ];
      fallback = true;
      use-xdg-base-directories = true;
      auto-optimise-store = true;

      auto-allocate-uids = true;
      use-cgroups = true;
      accept-flake-config = true;
      builders-use-substitutes = true;
    };
    extraOptions = ''
      !include ${config.age.secrets.tokens-nix.path}
    '';
  };
}
