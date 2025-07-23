# SSH service configuration
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable OpenSSH daemon
  services.openssh.enable = true;
}