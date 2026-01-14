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
      url = "github:nadevko/kasumi/dev";
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
      deploy-rs,
      kasumi,
      home-manager,
      nixpkgs,
      rycee,
      ...
    }@inputs:
    {
      lib = kasumi.lib.rebaseSelf self.mixins.lib nixpkgs.lib;
      nixosModules = kasumi.lib.collapseNixDir ./nixosModules;
      homeModules = kasumi.lib.collapseNixDir ./homeModules;

      mixins = {
        lib = kasumi.lib.readLibMixin ./lib;
        externals = final: prev: {
          inherit (import rycee { pkgs = final; }) mozilla-addons-to-nix firefox-addons;
        };
        externalsScope = kasumi.lib.toScopeMixin self.mixins.externals;
        packages = kasumi.lib.readRecursivePackagesMixin ./pkgs;
      };

      # nixosConfigurations = kasumi.lib.readNixosConfigurations nixpkgs.lib.nixosSystem (_: {
      #   specialArgs = { inherit inputs; };
      # }) ./nixosConfigurations;

      # homeConfigurations = kasumi.lib.readNixosConfigurations home-manager.lib.homeManagerConfiguration (
      #   _: {
      #     extraSpecialArgs = { inherit inputs; };
      #     pkgs = self.legacyPackages.x86_64-linux;
      #   }) ./homeConfigurations;

      deploy.nodes.cyrykiec = {
        hostname = "192.168.0.2";
        sshUser = "nadevko";
        user = "root";
        profiles.system.path =
          deploy-rs.lib.${self.nixosConfigurations.cyrykiec.config.nixpkgs.system}.activate.nixos
            self.nixosConfigurations.cyrykiec;
      };
    }
    //
      kasumi.lib.perScope nixpkgs { config.allowUnfree = true; }
        [ kasumi.mixins.augmentScope self.mixins.externalsScope self.mixins.packages ]
        (scope: {
          inherit (scope) packages legacyPackages;
          devShells.default = scope.callPackage ./shell.nix { inherit inputs; };
        });
}
