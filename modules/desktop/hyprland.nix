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

    home = {
      # Include all files in hypr/ one by one to not make the whole dir write protected
      xdg.configFile = (
        let
          hyprConfig = ../../dotfiles/hypr;
          paths = lib.attrNames (builtins.readDir hyprConfig);
          configs = map (name: { "hypr/${name}".source = "${hyprConfig}/${name}"; }) paths;
        in
        builtins.foldl' (a: b: a // b) { } configs
      );

      # Notification Manager
      services.mako = {
        enable = true;
        settings = {
          sort = "-time";
          ignore-timeout = 1;
          default-timeout = 3000;
          max-visible = 4;
          font = "JetBrainsMonoNerdFont Normal Regular 10";
        };
      };

      home.pointerCursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Original-Ice";
        size = 24;
        gtk.enable = true;
        x11.enable = true;
      };

      gtk = {
        enable = true;

        theme.package = pkgs.tokyonight-gtk-theme;
        theme.name = "Tokyonight-Dark";

        iconTheme.package = pkgs.gruvbox-plus-icons;
        iconTheme.name = "Gruvbox-Plus-Dark";

        gtk4.theme = null;
      };
    };
  };
}
