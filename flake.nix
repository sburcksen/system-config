{
  description = "My NixOS system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      lib = nixpkgs.lib.extend (final: prev: import ./lib.nix { lib = prev; });

      unfreePackages = [
        "spotify"
        "obsidian"
      ];

      specialArgs = {
        allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) unfreePackages;
        inherit inputs;
      };

      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = false;
          inherit (specialArgs) allowUnfreePredicate;
        };
      };

      # For standalone home-manager usage. Used to generate config.home
      dummySystem = lib.nixosSystem {
        system = "x86_64-linux";
        inherit specialArgs lib;
        modules = [
          ./modules
          {
            common.enable = true;
            desktop = {
              enable = true;
            };
            system.stateVersion = "25.11";
          }
        ];
      };

    in
    {
      # For standalone usage
      homeConfigurations.sburcksen = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          dummySystem.config.home
        ];
        extraSpecialArgs = { inherit inputs; };
      };

      nixosConfigurations = {
        pc = lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs lib;
          modules = [
            ./hosts/pc
          ];
        };

        laptop = lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs lib;
          modules = [
            ./hosts/laptop
          ];
        };

        nas = lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs lib;
          modules = [
            ./hosts/nas
          ];
        };
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
