{
  description = "Personal NixOS configurations and related stuff";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.systems.follows = "systems";
    };

    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kasumi = {
      url = "github:nadevko/kasumi/dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home";
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
      home,
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
      lib = k.rebaseSelf so.lib { };
      nixosModules = k.collapseNixDir ./nixosModules;
      homeModules = k.collapseNixDir ./homeModules;

      nixosConfigurations = k.readNixosConfigurations rec {
        specialArgs = { inherit inputs; };
        pkgs = self.legacyPackages.x86_64-linux;
        inherit (pkgs) lib;
      } (_: { }) ./nixosConfigurations;

      homeConfigurations = k.readConfigurations home.lib.homeManagerConfiguration rec {
        extraSpecialArgs = { inherit inputs; };
        pkgs = self.legacyPackages.x86_64-linux;
        inherit (pkgs) lib;
      } (_: { }) ./homeConfigurations;

      overlays = {
        default = k.byNameOverlayWithScopesFrom (k.readDirPaths ./pkgs);

        lib =
          final: prev:
          let
            lib0 = k.rebaseSelf (k.readLibOverlay ./lib) prev;
          in
          k.genLibAliases lib0 // lib0;

        augment = k.augmentLib (
          k.foldLayl [
            (_: _: nixpkgs.lib)
            ko.lib
            so.lib
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
          so.legacy
          agenix.overlays.default
          deploy-rs.overlays.default
          nix4vscode.overlays.default
          ko.compat
          ko.default
          so.augment
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
      packages = k.forPkgs nixpkgs { config.allowUnfree = true; } (
        k.fpipe [
          (pkgs: k.makeScopeWith pkgs (_: { }))
          (scope: scope.fuze so.environment)
          (scope: scope.rebase so.default)
          k.collapseScope
        ]
      );
      inherit
        (k.eachPkgs nixpkgs
          {
            config.allowUnfree = true;
            overlays = [
              so.environment
              so.default
            ];
          }
          (pkgs: {
            legacyPackages = pkgs;
            devShells.default = pkgs.callPackage ./shell.nix { };
          })
        )
        legacyPackages
        devShells
        ;
    };
}
