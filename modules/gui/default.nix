# GUI environment imports
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./gnome.nix
    ./hyprland.nix
  ];

  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
