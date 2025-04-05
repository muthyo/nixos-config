# GUI-related home configurations
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./waybar.nix
    # Add other GUI-related modules here in the future
    # ./wofi.nix
    # ./mako.nix
  ];
}
