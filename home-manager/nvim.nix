{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      lua-language-server
      nixd
      nixfmt
      clang-tools
      rust-analyzer
    ];
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withRuby = false;
    withPython3 = false;
  };
}
