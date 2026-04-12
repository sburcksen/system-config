{
  options,
  lib,
  inputs,
  config,
  ...
}:
{
  options.home = lib.mkOption {
    default = { };
    description = "Home Manager configuration";
  };
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  config.home-manager = {
    users."sburcksen" = lib.mkAliasDefinitions options.home;
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs; };
  };
  config.home.imports = [ ../home-manager ];
  config.home.home.stateVersion = config.system.stateVersion;
}
