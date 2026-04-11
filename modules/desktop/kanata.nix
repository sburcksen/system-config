{
  pkgs,
  config,
  lib,
  ...
}:

{
  options.desktop.kanata.enable = lib.mkSubOption config.desktop.enable "Kanata";

  config = lib.mkIf config.desktop.kanata.enable {
    services.udev.extraRules = ''
      KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';

    users.groups.uinput = { };

    environment.systemPackages = [
      pkgs.kanata
    ];
  };
}
