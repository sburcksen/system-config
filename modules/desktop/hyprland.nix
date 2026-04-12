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
      spotify
      vlc
      nerd-fonts.jetbrains-mono
    ];

    programs.hyprland.enable = true;
    programs.thunar.enable = true; # File explorer

    home = {
      xdg.configFile = {
        "waybar".source = ../../dotfiles/waybar;
      }
      # Include all files in hypr/ one by one to not make the whole dir write protected
      // (
        let
          hyprConfig = ../../dotfiles/hypr;
          paths = lib.attrNames (builtins.readDir hyprConfig);
          configs = map (name: { "hypr/${name}".source = "${hyprConfig}/${name}"; }) paths;
        in
        builtins.foldl' (a: b: a // b) { } configs
      );

      #home.packages = [
      #  pkgs.pkgs.nerd-fonts.jetbrains-mono
      #];

      fonts.fontconfig.enable = true;
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

      programs.wlogout = {
        enable = true;
        layout = [
          {
            label = "lock";
            action = "hyprlock";
            text = "Lock";
            keybind = "l";
          }
          {
            label = "hibernate";
            action = "systemctl hibernate";
            text = "Hibernate";
            keybind = "h";
          }
          {
            label = "logout";
            action = "hyprctl dispatch exit";
            text = "Logout";
            keybind = "e";
          }
          {
            label = "shutdown";
            action = "systemctl poweroff";
            text = "Shutdown";
            keybind = "s";
          }
          {
            label = "suspend";
            action = "systemctl suspend";
            text = "Suspend";
            keybind = "u";
          }
          {
            label = "reboot";
            action = "systemctl reboot";
            text = "Reboot";
            keybind = "r";
          }
        ];

        style = ''
          * {
          	font-family: "JetBrainsMono NF";
            font-size: 16;  
            transition: 20ms;
            background-image: none;
          	box-shadow: none;
          }

          window {
          	background-color: rgba(12, 12, 12, 0.9);
          }

          button {
            border-radius: 0;
            border-color: black;
          	text-decoration-color: #FFFFFF;
            color: #FFFFFF;
          	background-color: #1E1E1E;
          	border-style: solid;
          	border-width: 1px;
          	background-repeat: no-repeat;
          	background-position: center;
          	background-size: 15%;
          }

          button:focus, button:active {
          	background-color: #3700B3;
          	outline-style: none;
          }

          #lock {
              margin: 10px;
              border-radius: 20px;
              background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
          }

          #logout {
              margin: 10px;
              border-radius: 20px;
              background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
          }

          #suspend {
              margin: 10px;
              border-radius: 20px;
              background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
          }

          #hibernate {
             margin: 10px;
             border-radius: 20px;
             background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"));
          }

          #shutdown {
              margin: 10px;
              border-radius: 20px;
              background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
          }

          #reboot {
              margin: 10px;
              border-radius: 20px;
              background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
          }
        '';
      };
    };
  };
}
