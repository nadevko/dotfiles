{
  description = "Personal NixOS configurations and related stuff";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nuschtosSearch.follows = "nuschtosSearch";
      inputs.systems.follows = "systems";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nabiki = {
      url = "github:nadevko/nabiki/v2-alpha";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.treefmt-nix.follows = "treefmt-nix";
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

    mozilla-addons-to-nix = {
      url = "sourcehut:~rycee/mozilla-addons-to-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.pre-commit-hooks.follows = "pre-commit-hooks";
    };

    firefox-addons = {
      url = "sourcehut:~rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
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

    nuschtosSearch = {
      url = "github:NuschtOS/search";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
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
      treefmt-nix,
      deploy-rs,
      nabiki,
      home-manager,
      nixpkgs,
      ...
    }@inputs:
    let
      private = nixpkgs.lib.composeExtensions self.overlays.lib (_: _: { inherit inputs; });
      libOverlay = nabiki.lib.readLibOverlay ./lib;

      perPackages =
        prevPkgs:
        let
          pkgs =
            (import nixpkgs {
              config.allowUnfree = true;
              inherit (prevPkgs) system;
            }).extend
              self.overlays.lib;
          treefmt = treefmt-nix.lib.evalModule pkgs {
            programs.nixfmt = {
              enable = true;
              strict = true;
            };
          };
        in
        rec {
          # BUG: pre v2-alpha-2 hotfix
          legacyPackages = pkgs.extend (_: _: packages);
          packages = inputs.nabiki.lib.rebase self.overlays.default pkgs;
          devShells = nabiki.lib.rebase (nabiki.lib.readDevShellsOverlay { } private ./pkgs) pkgs;
          formatter = treefmt.config.build.wrapper;
          checks.treefmt = treefmt.config.build.check self;
        };
    in
    nabiki.lib.mapAttrsNested nixpkgs.legacyPackages perPackages
    // {
      lib = (nabiki.lib.makeRecExtensible (_: nixpkgs.lib)).recExtend libOverlay;

      overlays = {
        # BUG: pre v2-alpha-2 hotfix
        default = nixpkgs.lib.composeExtensions nabiki.overlays.default (
          _: prev:
          let
            overlay = nabiki.lib.rebase (nabiki.lib.readPackagesOverlay { } private ./pkgs) prev;
          in
          nixpkgs.lib.concatMapAttrs (
            name: value:
            if nixpkgs.lib.isDerivation value then
              nabiki.lib.nameValuePair' name value
            else
              nixpkgs.lib.mapAttrs' (pname: package: nixpkgs.lib.nameValuePair "${name}-${pname}" package) (
                removeAttrs value [
                  "override"
                  "overrideDerivation"
                ]
              )
          ) overlay
        );
        lib = nabiki.lib.wrapLibExtension libOverlay;
      };

      nixosConfigurations = nabiki.lib.getConfigurations nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
      } { } ./nixosConfigurations;

      nixosModules = nabiki.lib.readModulesFlatten ./nixosModules;

      homeConfigurations = nabiki.lib.getConfigurations home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = { inherit inputs; };
        pkgs = self.legacyPackages.x86_64-linux;
      } { } ./homeConfigurations;

      homeModules = nabiki.lib.readModulesFlatten ./homeModules;

      deploy.nodes.cyrykiec = {
        hostname = "192.168.0.2";
        sshUser = "nadevko";
        user = "root";
        profiles.system.path =
          deploy-rs.lib.${self.nixosConfigurations.cyrykiec.config.nixpkgs.system}.activate.nixos
            self.nixosConfigurations.cyrykiec;
      };
    };
}
