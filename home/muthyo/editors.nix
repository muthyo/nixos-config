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

    # You can also add plugins if needed
    plugins = with pkgs.vimPlugins; [
      # Add any plugins you want here
    ];
  };
  home.file.".vimrc".source = ../dotfiles/vimrc;

  # Configure Helix
  programs.helix.enable = true;
  xdg.configFile."helix/config.toml".source = ../dotfiles/helix/config.toml;
  xdg.configFile."helix/languages.toml".source = ../dotfiles/helix/languages.toml;

  # Comment out line under for future use of neovim and create the ../kickstart.nvim directory
  # programs.neovim.enable = false;
  # xdg.configFile."nvim" = {
  #   source = ../kickstart.nvim;
  #   recursive = true;
  # };
}
