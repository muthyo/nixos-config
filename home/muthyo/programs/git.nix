# Git configuration
{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "muthyo";
    includes = [
      {path = "~/.config/git/sensitive-config";}
    ];
    extraConfig = {
      core.editor = "hx";
      init.defaultBranch = "main";
    };
  };
}