# Git configuration
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Configure Git
  programs.git = {
    enable = true;
    userName = "muthyo";
    includes = [
      {path = "~/.config/git/sensitive-config";}
    ];
    extraConfig = {
      core = {
        editor = "hx";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
