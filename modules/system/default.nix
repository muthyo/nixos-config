# System module imports
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./core.nix
    ./fonts.nix
    ./audio.nix
  ];
}
