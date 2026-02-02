{
  description = "Personal NixOS configurations and related stuff";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.systems.follows = "systems";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kasumi = {
      url = "github:nadevko/kasumi";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.systems.follows = "systems";
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
      inputs.flake-compat.follows = "flake-compat";
    };

    nix4vscode = {
      url = "github:nix-community/nix4vscode";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };

    rycee = {
      url = "sourcehut:~rycee/nur-expressions";
      flake = false;
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };

    # follows optimisation

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/default";
    flake-compat.url = "github:edolstra/flake-compat";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
    };
  };

  outputs =
    {
      self,
      kasumi,
      nixpkgs,
      home-manager,
      rycee,
      spicetify-nix,
      deploy-rs,
      agenix,
      nix4vscode,
      ...
    }@inputs:
    let
      so = self.overlays;
      k = kasumi.lib;
      ko = kasumi.overlays;
    in
    {
      nixosModules = k.collapseNixDir ./nixosModules;
      homeModules = k.collapseNixDir ./homeModules;

      nixosConfigurations = k.readNixosConfigurations {
        specialArgs.inputs = inputs;
        pkgs = self.legacyPackages.x86_64-linux;
      } (_: { }) ./nixosConfigurations;

      homeConfigurations = k.readConfigurations home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs.inputs = inputs;
        pkgs = self.legacyPackages.x86_64-linux;
      } (_: { }) ./homeConfigurations;

      overlays = {
        default = k.byNameOverlayWithScopesFrom (k.readDirPaths ./pkgs);

        augment = k.augmentLib (
          k.foldLayl [
            (_: _: nixpkgs.lib)
            (final: _: { hm = import (home-manager + "/modules/lib") { lib = final; }; })
            ko.lib
          ]
        );

        legacy = final: prev: {
          inherit (import rycee { pkgs = final; }) mozilla-addons-to-nix firefox-addons;
          spicePkgs = import (spicetify-nix + "/pkgs") {
            pkgs = final;
            unfreePkgs = final;
          };
        };

        environment = k.foldLay [
          so.augment
          so.legacy
          agenix.overlays.default
          deploy-rs.overlays.default
          nix4vscode.overlays.default
          ko.compat
          ko.default
        ];
      };

      deploy.nodes.cyrykiec = {
        hostname = "192.168.0.2";
        sshUser = "nadevko";
        user = "root";
        profiles.system.path =
          deploy-rs.lib.${self.nixosConfigurations.cyrykiec.config.nixpkgs.system}.activate.nixos
            self.nixosConfigurations.cyrykiec;
      };

      packages = k.forAllPkgs nixpkgs { config.allowUnfree = true; } (
        k.fpipe [
          (pkgs: k.makeScopeWith pkgs (_: { }))
          (scope: scope.fuses so.environment)
          (scope: scope.rebase so.default)
          k.collapseScope
        ]
      );

      legacyPackages = k.forAllPkgs nixpkgs {
        config.allowUnfree = true;
        overlays = [
          so.environment
          so.default
        ];
      } nixpkgs.lib.id;

      devShells = k.forAllPkgs self { } (pkgs: {
        default = pkgs.callPackage ./shell.nix { };
      });

      formatter = k.forAllPkgs self { } (pkgs: pkgs.flake-fmt-nixfmt);
    };
}
