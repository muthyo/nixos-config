# Explicitly disable conflicting XDG portal implementations
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Disable the Hyprland portal
  xdg.portal = {
    enable = true;
    extraPortals = lib.mkForce [];
    wlr.enable = lib.mkForce false;
  };
}
