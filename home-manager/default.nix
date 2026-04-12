{ ... }:

{
  imports = [
    ./browser.nix
    ./desktop-packages.nix
    ./dotfiles.nix
    ./fish.nix
    ./fonts.nix
    ./git.nix
    ./mako.nix
    ./nvim.nix
    ./terminal.nix
    ./theme.nix
    ./wlogout.nix
  ];

  home.username = "sburcksen";
  home.homeDirectory = "/home/sburcksen";
}
