# Git configuration
{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    includes = [
      {path = "~/.config/git/sensitive-config";}
    ];
    settings = {
      user.name = "muthyo";
      core.editor = "hx";
      init.defaultBranch = "main";
    };
  };

  programs.lazygit = {
    enable = true;
  };
}