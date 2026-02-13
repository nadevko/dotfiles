{
  nixConfig.extra-experimental-features = [
    "pipe-operators"
    "no-url-literals"
  ];

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    bsuir = {
      url = "git+file:/home/nadevko/Workspace/bsuir";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kasumi = {
      url = "github:nadevko/kasumi";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      nixpkgs,
      kasumi,
      home-manager,
      agenix,
      deploy-rs,
      nix4vscode,
      rycee,
      spicetify-nix,
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
        specialArgs = inputs // {
          inherit inputs;
        };
        pkgs = self.legacyPackages.x86_64-linux;
      } (_: { }) ./nixosConfigurations;

      homeConfigurations = k.readConfigurations home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = inputs // {
          inherit inputs;
        };
        pkgs = self.legacyPackages.x86_64-linux;
      } (_: { }) ./homeConfigurations;

      overlays = {
        default = k.comfyByNameOverlayFrom <| k.readDirPaths ./pkgs;

        augment =
          k.augmentLib
          <| k.fuseLayl ko.lib (final: _: { hm = import (home-manager + "/modules/lib") { lib = final; }; });

        legacy = final: _: {
          inherit (import rycee { pkgs = final; }) mozilla-addons-to-nix firefox-addons;
          spicePkgs = import (spicetify-nix + "/pkgs") {
            pkgs = final;
            unfreePkgs = final;
          };
        };

        environment = k.foldLay [
          ko.compat
          ko.default
          so.augment
          so.legacy
          agenix.overlays.default
          deploy-rs.overlays.default
          nix4vscode.overlays.default
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
        pkgs:
        pkgs
        |> k.makeLayer so.environment
        |> k.rebaseLayerTo so.default
        |> k.collapseSupportedBy pkgs.stdenv.hostPlatform.system
      );

      legacyPackages = k.importPkgsForAll nixpkgs {
        config.allowUnfree = true;
        overlays = [
          so.environment
          so.default
        ];
      };

      devShells = k.forAllPkgs self { } (pkgs: {
        default = pkgs.callPackage ./shell.nix { };
      });

      formatter = k.forAllPkgs self { } <| builtins.getAttr "kasumi-fmt";
    };
}
