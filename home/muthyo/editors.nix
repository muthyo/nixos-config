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
  # home.file.".vimrc".source = ../dotfiles/vimrc;
  xdg.configFile.".vimrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/dotfiles/vimrc";

  # Configure Helix with symlinks
  programs.helix.enable = true;
  xdg.configFile."helix".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/dotfiles/helix";
}
