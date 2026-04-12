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

    home = {
      programs.fish = {
        enable = true;
        plugins = [
        ];
        functions = {
        };

        interactiveShellInit = ''
          # Fish greeting
          function fish_greeting; end

          # Fish text colors
          set fish_color_autosuggestion 4D5566
          set fish_color_cancel \x2d\x2dreverse
          set fish_color_command 39BAE6
          set fish_color_comment 626A73
          set fish_color_end F29668
          set fish_color_error FF3333
          set fish_color_escape 95E6CB
          set fish_color_history_current \x2d\x2dbold
          set fish_color_keyword \x1d
          set fish_color_normal B3B1AD
          set fish_color_operator E6B450
          set fish_color_option 227826
          set fish_color_param B3B1AD
          set fish_color_quote C2D94C
          set fish_color_redirection FFEE99
          set fish_color_search_match \x2d\x2dbackground\x3d39BAE6
          set fish_color_selection \x2d\x2dbackground\x3d9BAE6
          set fish_color_valid_path \x2d\x2dunderline

          # Fish Pager colors
          set fish_pager_color_background \x1d
          set fish_pager_color_completion normal
          set fish_pager_color_description B3A06D
          set fish_pager_color_prefix normal\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
          set fish_pager_color_progress brwhite\x1e\x2d\x2dbackground\x3dcyan
          set fish_pager_color_selected_background \x2d\x2dbackground\x3d39BAE6
          set fish_pager_color_selected_completion 000000
          set fish_pager_color_selected_description 000000
          set fish_pager_color_selected_prefix 000000
        '';
      };

      programs.starship = {
        enable = true;
        enableFishIntegration = true;
        settings = {
          add_newline = true;
        };
      };
    };
  };
}
