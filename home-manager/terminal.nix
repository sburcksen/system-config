{ ... }:

{
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
}
