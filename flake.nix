{
  description = "Personal NixOS configurations and related stuff";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
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
      url = "github:nadevko/nabiki/v1";
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
      agenix,
      deploy-rs,
      nabiki,
      home-manager,
      nixpkgs,
      ...
    }@inputs:
    {
      nixosConfigurations = builtins.mapAttrs (
        name: _:
        nixpkgs.lib.nixosSystem {
          modules = nabiki.lib.listModules { path = ./nixos/configurations/${name}; };
          specialArgs = { inherit inputs; };
        }
      ) (builtins.readDir ./nixos/configurations);
      homeConfigurations = builtins.mapAttrs (
        name: _:
        home-manager.lib.homeManagerConfiguration {
          modules = nabiki.lib.listModules { path = ./home/configurations/${name}; };
          extraSpecialArgs = { inherit inputs; };
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        }
      ) (builtins.readDir ./home/configurations);
      deploy.nodes.cyrykiec = {
        hostname = "192.168.0.2";
        sshUser = "nadevko";
        user = "root";
        profiles.system.path =
          deploy-rs.lib.${self.nixosConfigurations.cyrykiec.config.nixpkgs.system}.activate.nixos
            self.nixosConfigurations.cyrykiec;
      };
      lib = import ./lib inputs // {
        maintainers = import ./lib/maintainers.nix inputs;
      };
      nixosModules = nabiki.lib.readModulesFlatten { path = ./nixos/modules; };
      homeModules = nabiki.lib.readModulesFlatten { path = ./home/modules; };
    }
    // nabiki [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ] (
      system:
      let
        pkgs = import nixpkgs {
          config.allowUnfree = true;
          inherit system;
        };
        treefmt = treefmt-nix.lib.evalModule pkgs {
          programs.nixfmt = {
            enable = true;
            strict = true;
          };
        };
      in
      {
        packages = nabiki.lib.readPackages {
          path = ./pkgs;
          overrides.inputs = inputs;
          inherit pkgs;
        };
        legacyPackages = nabiki.lib.readLegacyPackages {
          path = ./pkgs;
          overrides.inputs = inputs;
          inherit pkgs;
        };
        devShells.default = pkgs.mkShell {
          packages = [
            agenix.packages.${pkgs.system}.default
            deploy-rs.packages.${pkgs.system}.default
            nabiki.packages.${pkgs.system}.nabiki-update
          ];
        };
        formatter = treefmt.config.build.wrapper;
        checks.treefmt = treefmt.config.build.check self;
      }
    );
}
