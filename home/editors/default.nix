# Editor configurations
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./vim.nix
    ./helix.nix
  ];
}
