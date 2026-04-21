{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.desktop.devPkgs.enable = lib.mkSubOption config.desktop.enable "development packages";

  config = lib.mkIf config.desktop.devPkgs.enable {
    environment.systemPackages = with pkgs; [
      gcc
      clang
      gnumake
      cmake
      gdb
      python3
      rustup
      ghc
      haskell-language-server
      cabal-install
    ];

    home = {
      programs.foot = {
        enable = true;

        settings = {
          main = {
            font = "JetBrainsMonoNerdFont-Regular:size=12";
            pad = "3x0";
          };
          colors-dark.alpha = 0.8;
        };
      };
    };
  };
}
