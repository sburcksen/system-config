{
  pkgs,
  config,
  lib,
  ...
}:

{
  options.desktop.hyprland.enable = lib.mkSubOption config.desktop.enable "Hyprland";

  config = lib.mkIf config.desktop.hyprland.enable {
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
  };
}
