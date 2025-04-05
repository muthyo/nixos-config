# Helix configuration
{
  config,
  pkgs,
  ...
}: {
  # Enable Helix editor
  programs.helix.enable = true;

  # Create symlink to your helix configuration
  xdg.configFile."helix".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixos-config/home/dotfiles/helix";
}
