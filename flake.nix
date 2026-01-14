{
  description = "Personal NixOS configurations and related stuff";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";

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
    let
      getOverride = _: { };
      groups = builtins.groupBy (x: x.stem) (kasumi.lib.listShallowNixes ./pkgs);
      buildersSet = kasumi.lib.makeCallPackageSet getOverride (builtins.listToAttrs groups.builder);
      packagesGroup = groups.package ++ groups."";
      packagesSet = kasumi.lib.makeCallPackageSet getOverride (builtins.listToAttrs packagesGroup);
      scopeSet = kasumi.lib.makeCallScopeSet getOverride (builtins.listToAttrs groups.scope);
    in
    {
      lib = kasumi.lib.rebase self.overlays.lib nixpkgs.lib;
      nixosModules = kasumi.lib.flatifyModules ./nixosModules;
      homeModules = kasumi.lib.flatifyModules ./homeModules;

      overlays = {
        default = final: prev: scopeSet final // packagesSet final;
        lib = kasumi.lib.importAliasedNixTreeOverlay' ./lib;
        builders = final: prev: buildersSet final;
        externals = final: prev: {
          inherit (import rycee { pkgs = final; }) mozilla-addons-to-nix firefox-addons;
        };
      };

      deploy.nodes.cyrykiec = {
        hostname = "192.168.0.2";
        sshUser = "nadevko";
        user = "root";
        profiles.system.path =
          deploy-rs.lib.${self.nixosConfigurations.cyrykiec.config.nixpkgs.system}.activate.nixos
            self.nixosConfigurations.cyrykiec;
      };

      nixosConfigurations = kasumi.lib.readNixosConfigurations nixpkgs.lib.nixosSystem (_: {
        specialArgs = { inherit inputs; };
      }) ./nixosConfigurations;

      homeConfigurations = kasumi.lib.readNixosConfigurations home-manager.lib.homeManagerConfiguration (
        _: {
          extraSpecialArgs = { inherit inputs; };
          pkgs = self.legacyPackages.x86_64-linux;
        }) ./homeConfigurations;
    }
    //
      kasumi.lib.perSystem nixpkgs
        (
          system:
          (kasumi.lib.makeLegacyPackages (
            _:
            import nixpkgs {
              inherit system;
              config.allowUnfree = true;
              config.permittedInsecurePackages = [ "gradle-7.6.6" ];
            }
          )).overrideList
            [
              (kasumi.lib.wrapLibOverlay "kasumi-lib" kasumi.overlays.lib)
              (kasumi.lib.wrapLibOverlay "nadevko-lib" self.overlays.lib)
              self.overlays.externals
              self.overlays.builders
            ]
        )
        (pkgs: {
          devShells.default = pkgs.callPackage ./shell.nix { inherit inputs; };
          legacyPackages = pkgs.overrideBy self.overlays.default;

          packages =
            let
              scope = kasumi.lib.makeScope (final: self.overlays.default final final) pkgs.newScope;
              scopeNames = map (x: x.name) groups.scope;
              garbage = [
                "override"
                "overrideDerivation"
              ];
              names =
                ignore: attrs: builtins.filter (n: !builtins.elem n (garbage ++ ignore)) (builtins.attrNames attrs);
            in
            pkgs.lib.genAttrs (names scopeNames scope.packages) (n: scope.packages.${n})
            // builtins.listToAttrs (
              builtins.concatMap (
                n:
                let
                  inner = scope.${n}.packages or scope.${n};
                in
                map (p: {
                  name = "${n}-${p}";
                  value = inner.${p};
                }) (names [ ] inner)
              ) scopeNames
            );
        });
}
