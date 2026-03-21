{
  config,
  lib,
  pkgs,
  ...
}: {
  services.openssh = {
    enable = true;
    settings = {
      # Disable password auth — use SSH keys only
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      # Disallow direct root login
      PermitRootLogin = "no";
    };
  };
}
