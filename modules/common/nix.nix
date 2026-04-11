{
  allowUnfreePredicate,
  config,
  lib,
  ...
}:

{
  options.common.nix.enable = lib.mkSubOption config.common.enable "general Nix settings";

  config = lib.mkIf config.common.nix.enable {
    # Enable Nix Flakes
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    nix.channel.enable = false;
    nix.settings.use-xdg-base-directories = true;

    # Explicitly require unfree packages to be specified
    nixpkgs.config = {
      allowUnfree = false;
      inherit allowUnfreePredicate;
    };

    system.stateVersion = "24.11";
  };
}
