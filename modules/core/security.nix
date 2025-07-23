# Security and authentication configuration
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable rtkit for audio
  security.rtkit.enable = true;

  # GnuPG configuration
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    settings = {
      default-cache-ttl = 3600;
      max-cache-ttl = 36000;
    };
  };

  # Increase file descriptor limits
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "1048576";
    }
    {
      domain = "*";
      type = "hard";
      item = "nofile";
      value = "1048576";
    }
  ];
}