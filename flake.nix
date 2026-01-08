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

    k = {
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
      k,
      home-manager,
      nixpkgs,
      ...
    }@inputs:
    let
      libOverlay = k.lib.getLibOverlay ./lib;

      readPackagesFixedPoint' = targets: k.lib.readPackagesFixedPoint ./pkgs targets (_: { });
      buildersFixedPoint = readPackagesFixedPoint' [ "builder.nix" ];
      packagesFixedPoint = readPackagesFixedPoint' [ "package.nix" ];

      privateUnscope =
        newScope:
        nixpkgs.lib.customisation.makeScope newScope (_: {
          inherit inputs;
        });

      buildersUnscope =
        newScope: nixpkgs.lib.customisation.makeScope (privateUnscope newScope).newScope buildersFixedPoint;

      packagesUnscope =
        newScope:
        nixpkgs.lib.customisation.makeScope (buildersUnscope newScope).newScope packagesFixedPoint;

      mergedUnscope =
        newScope:
        (buildersUnscope newScope).overrideScope (nixpkgs.lib.trivial.flip (_: packagesFixedPoint));
    in
    {
      lib = k.lib.rebase libOverlay nixpkgs.lib;
      nixosModules = k.lib.flatifyModules ./nixosModules;
      homeModules = k.lib.flatifyModules ./homeModules;

      overlays = {
        lib = k.lib.wrapLibOverlay libOverlay;
        packages = k.lib.unscopeToOverlay packagesUnscope;
        packages' = k.lib.unscopeToOverlay' "nadevko" mergedUnscope;
      };

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
      k.lib.genFromPkgs nixpkgs
        {
          config.allowUnfree = true;
          config.permittedInsecurePackages = [ "gradle-7.6.6" ];
        }
        (
          pkgs:
          let
            treefmt = treefmt-nix.lib.evalModule pkgs {
              programs.nixfmt = {
                enable = true;
                strict = true;
              };
            };
            packagesScope = packagesUnscope pkgs.newScope;
          in
          {
            formatter = treefmt.config.build.wrapper;
            checks.treefmt = treefmt.config.build.check self;
            devShells.default = pkgs.callPackage ./shell.nix { inherit inputs; };
            packages = k.lib.rebaseScope packagesScope;
            legacyPackages = pkgs.extend self.overlays.packages';
          }
        );
}
