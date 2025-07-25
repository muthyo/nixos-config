# COSMIC Desktop Environment
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  # Import COSMIC module unconditionally
  imports = [
    inputs.nixos-cosmic.nixosModules.default
  ];

  options.desktop.cosmic.enable = lib.mkEnableOption "COSMIC desktop environment" // {
    default = true;
  };

  config = lib.mkIf config.desktop.cosmic.enable {
    # Add COSMIC binary cache
    nix.settings = {
      substituters = ["https://cosmic.cachix.org/"];
      trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
    };

    # Enable COSMIC desktop
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;

    # Optional: Enable Flatpak for additional app support
    services.flatpak.enable = lib.mkDefault true;
  };
}
