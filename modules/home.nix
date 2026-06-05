{
  options,
  lib,
  inputs,
  config,
  ...
}:
{
  options.home = lib.mkOption {
    # used by /home/default.nix
    type = lib.types.deferredModule;
    default = { };
    description = "Home Manager configuration";
  };

  imports = [ inputs.home-manager.nixosModules.home-manager ];

  config = {
    home-manager = {
      users."sburcksen" = lib.mkAliasDefinitions options.home;
      useUserPackages = true;
      useGlobalPkgs = true;
      extraSpecialArgs = { inherit inputs; };

      sharedModules = [
        inputs.nvf.homeManagerModules.default
      ];
    };

    home = {
      imports = [ ../home-manager ];

      home.username = "sburcksen";
      home.homeDirectory = "/home/sburcksen";

      home.stateVersion = config.system.stateVersion;
    };
  };
}
