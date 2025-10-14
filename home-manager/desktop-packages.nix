{ pkgs, ... }:

{
  home.packages = with pkgs; [
    spotify
    vesktop
    obsidian
    vlc
  ];
}
