{
  config,
  pkgs,
  ...
}: {
  # Configure Vim properly
  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ../dotfiles/vimrc;
  };

  # Configure Helix with symlinks
  programs.helix.enable = true;
  xdg.configFile."helix".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/dotfiles/helix";
}
