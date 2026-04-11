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
      };

      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = false;
          inherit (specialArgs) allowUnfreePredicate;
        };
      };

      # For usage with nixos
      homeManager = {
        imports = [ home-manager.nixosModules.home-manager ];
        home-manager = {
          users."sburcksen" = self.homeManagerModules.default;
          useUserPackages = true;
          useGlobalPkgs = true;
          extraSpecialArgs = { inherit inputs; };
        };
      };
    in
    {
      homeManagerModules.default = import ./home-manager;

      # For standalone usage
      homeConfigurations.sburcksen = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          self.homeManagerModules.default
        ];
        extraSpecialArgs = { inherit inputs; };
      };

      nixosConfigurations = {
        pc = lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs lib;
          modules = [
            ./hosts/desktop
            homeManager
          ];
        };

        laptop = lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs lib;
          modules = [
            ./hosts/laptop
            homeManager
          ];
        };

        nas = lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs lib;
          modules = [
            ./hosts/nas
            #homeManager
          ];
        };
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
