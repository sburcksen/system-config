{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    waybar
    hyprpaper # Wallpaper
    hypridle
    hyprlock # Lockscreen
    hyprshot # Screenshots
    wlogout
    pavucontrol # Audio control GUI
    cliphist
    wofi # Program launcher
    mako # Notifications
    iwgtk # Wifi GUI
    brightnessctl
    nwg-displays # Display Control GUI
    feh # Image Viewer
    jq # JSON parser required for custom workspace switch behavior
  ];

  programs.hyprland.enable = true;
  programs.thunar.enable = true; # File explorer

  services.displayManager.ly.enable = true; # Login manager
}
