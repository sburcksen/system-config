{
  pkgs,
  config,
  lib,
  ...
}:

{
  options.common.shell.enable = lib.mkSubOption config.common.enable "shell configuration";

  config = lib.mkIf config.common.shell.enable {
    environment.systemPackages = with pkgs; [
      ripgrep
      wget
      unzip
      killall
      fd
      fzf
    ];

    programs.fish.enable = true;

    # Exclude
    programs.nano.enable = false;
  };
}
