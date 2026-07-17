{
  config,
  lib,
  pkgs,
  ...
}: {
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
      programs.vscodium = {
        enable = true;

        profiles.default = {
          userSettings = {
            "editor.fontFamily" = "'JetBrainsMono'";

            "editor.tabSize" = 4;
            "editor.insertSpaces" = true;
            "editor.detectIndentation" = true;

            "editor.formatOnSave" = true;
            "editor.lineNumbers" = "relative";

            "editor.minimap.enabled" = false;
            "editor.guides.bracketPairs" = true;
            "editor.inlineSuggest.enabled" = true;

            "editor.cursorSurroundingLines" = 8;
            "editor.cursorSmoothCaretAnimation" = "on";
            "editor.smoothScrolling" = true;

            "files.trimTrailingWhitespace" = true;
            "files.insertFinalNewline" = true;

            "workbench.colorTheme" = "Catppuccin Mocha";
            "workbench.iconTheme" = "catppuccin-mocha";
            "workbench.startupEditor" = "none";
            "workbench.editor.enablePreview" = false;

            "breadcrumbs.enabled" = true;
            "security.workspace.trust.enabled" = false;

            "git.openRepositoryInParentFolders" = "always";
            "git.autofetch" = true;
            "git.confirmSync" = false;

            "telemetry.telemetryLevel" = "off";

            "extensions.autoUpdate" = false;
            "extensions.autoCheckUpdates" = false;

            # Extensions
            "haskell.manageHLS" = "PATH";

            "vim.useSystemClipboard" = true;
            "vim.hlsearch" = true;
            "vim.incsearch" = true;
            "vim.leader" = "<space>";
            "vim.camelCaseMotion.enable" = true;
            "vim.visualstar" = true;
          };

          extensions = with pkgs.vscode-extensions; [
            # General
            vscodevim.vim
            esbenp.prettier-vscode
            catppuccin.catppuccin-vsc
            catppuccin.catppuccin-vsc-icons

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
            ms-python.python
            #ms-python.vscode-pylance

            #anthropic.claude-code
          ];
        };
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
