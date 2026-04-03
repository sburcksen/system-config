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
      inherit (nixpkgs) lib;

      unfreePackages = [
        "spotify"
        "obsidian"
      ];

      specialArgs = {
        modules = import ./modules lib;
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
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs;
          modules = [
            ./hosts/desktop
            homeManager
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs;
          modules = [
            ./hosts/laptop
            homeManager
          ];
        };

        nas = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs;
          modules = [
            ./hosts/nas
          ];
        };
      };

      formatter.x86_64-linux = pkgs.nixfmt-tree;
    };
}
