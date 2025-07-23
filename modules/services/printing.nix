# Printing services
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable CUPS for printing
  services.printing.enable = true;
}