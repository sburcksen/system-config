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
      haskell-language-server
      cabal-install
    ];

    home = {
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
      programs.git = {
        enable = true;

        signing.format = null;

        settings = {
          user.name = "Sam Burcksen";
          user.email = "sam.burcksen@gmail.com";

          apply.whitespace = "fix";
          branch.sort = "-committerdate";
          color.ui = "auto";

          core = {
            editor = "nvim";

            # Speed up commands involving untracked files such as `git status`.
            # https://git-scm.com/docs/git-update-index#_untracked_cache
            untrackedCache = true;

            # Treat spaces before tabs and all kinds of trailing whitespace as an error.
            # [default] trailing-space: looks for spaces at the end of a line
            # [default] space-before-tab: looks for spaces before tabs at the beginning of a line
            whitespace = "space-before-tab,-indent-with-non-tab,trailing-space";
          };

          credential.helper = "store";
          init.defaultBranch = "main";

          push = {
            default = "simple";

            # Make `git push` push relevant annotated tags when pushing branches out.
            followTags = true;
          };

          aliases = {
            # List aliases.
            aliases = "config --get-regexp alias";

            # Pull in remote changes for the current repository and all its submodules.
            p = "pull --recurse-submodules";

            # Clone a repository including all submodules.
            c = "clone --recursive";

            # Commit all changes.
            ca = "!git add ':(exclude,attr:builtin_objectmode=160000)' && git commit -av";

            # View abbreviated SHA, description, and history graph of the latest 20 commits.
            l = "log --pretty=oneline -n 20 --graph --abbrev-commit";

            # View the current working tree status using the short format.
            s = "status -s";

            # Show the diff between the latest commit and the current state.
            d = ''!"git diff-index --quiet HEAD -- || clear; git --no-pager diff --patch-with-stat"'';

            # Amend the currently staged files to the latest commit.
            amend = "commit --amend --reuse-message=HEAD";

            # Show the user email for the current repository.
            whoami = "config user.email";
          };
        };
      };
    };
  };
}
