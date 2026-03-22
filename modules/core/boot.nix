{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  zramSwap.enable = true;
  boot.kernel.sysctl = {
    # Keep memory pressure low for gaming/desktop workloads
    "vm.swappiness" = 10;
    # Required by some games and apps (e.g. Elasticsearch, Steam)
    "vm.max_map_count" = 1048576;
  };

  # Disable split-lock detection to avoid performance issues on some workloads
  boot.kernelParams = ["split_lock_detect=off"];

  services.fstrim.enable = true;
  systemd.oomd.enable = true;
}
