# Boot configuration
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # System optimizations
  zramSwap.enable = true;
  boot.kernel.sysctl."vm.swappiness" = 10;

  # Enable SSD optimizations
  services.fstrim.enable = true;

  # Enable systemd-oomd for better memory management
  systemd.oomd.enable = true;

  # Gaming-specific kernel parameters
  boot.kernel.sysctl = {
    "vm.max_map_count" = 1048576;
  };

  boot.kernelParams = [
    # NVIDIA parameters
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
    # Gaming-specific parameters
    "split_lock_detect=off"
  ];
}