# bcachefs support module
{
  config,
  lib,
  pkgs,
  bcachefsPkgs,
  ...
}: {
  # Use a newer kernel that supports bcachefs
  boot.kernelPackages = bcachefsPkgs.linuxPackages_latest;

  # Add bcachefs kernel module
  boot.supportedFilesystems = ["bcachefs"];

  # Add bcachefs tools
  environment.systemPackages = with bcachefsPkgs; [
    bcachefs-tools
  ];

  # bcachefs mount options if you want to add defaults
  # fileSystems."/" = lib.mkIf (config.fileSystems."/".fsType == "bcachefs") {
  #   options = [ "compression=zstd" ];
  # };
}
