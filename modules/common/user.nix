{
  pkgs,
  config,
  lib,
  ...
}:

{
  options.common.user.enable = lib.mkSubOption config.common.enable "user configuration";

  config = lib.mkIf config.common.user.enable {
    users.users.sburcksen = {
      description = "Sam Burcksen";
      isNormalUser = true;
      createHome = true;
      home = "/home/sburcksen";
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "input" # input and uinput required by kanata
        "uinput"
      ];
    };
  };
}
