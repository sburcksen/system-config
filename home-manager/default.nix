{ ... }:

{
  imports = [
    ./browser.nix
    ./desktop-packages.nix
    ./dotfiles.nix
    ./fonts.nix
    ./git.nix
    ./nvim.nix
    ./terminal.nix
    ./wlogout.nix
  ];

  home.username = "sburcksen";
  home.homeDirectory = "/home/sburcksen";
}
