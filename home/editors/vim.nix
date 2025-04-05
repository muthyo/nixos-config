# Vim configuration
{
  config,
  pkgs,
  ...
}: {
  # Configure Vim properly
  programs.vim = {
    enable = true;

    # This is the important part - it pulls content from your vimrc file
    extraConfig = builtins.readFile ../dotfiles/vimrc;
  };

  # Create a symlink to ensure the vimrc is accessible
  xdg.configFile.".vimrc".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixos-config/home/dotfiles/vimrc";
}
