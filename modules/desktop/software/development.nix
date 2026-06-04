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
      cabal-install
    ];

    home = {
      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;

        userSettings = {
          "editor.formatOnSave" = true;
          "editor.lineNumbers" = "relative";
          "editor.cursorSurroundingLines" = 8;
          "editor.cursorSmoothCaretAnimation" = true;

          "security.workspace.trust.enabled" = false;

          "git.openRepositoryInParentFolders" = "always";

          "haskell.manageHLS" = "PATH";
        };

        profiles.default.extensions = with pkgs.vscode-extensions; [
          # General
          vscodevim.vim

          # Haskell
          haskell.haskell
          justusadam.language-haskell

          # Nix
          jnoortheen.nix-ide

          # C/C++
          llvm-vs-code-extensions.vscode-clangd

          # Lua
          # sumneko.lua

          # Rust
          rust-lang.rust-analyzer

          # Python
          #ms-python.python
          #ms-python.vscode-pylance

          #anthropic.claude-code
        ];
      };

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
