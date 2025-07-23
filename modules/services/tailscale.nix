# Tailscale VPN service
{
  config,
  lib,
  pkgs,
  ...
}: {
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "client";
  };

  environment.systemPackages = with pkgs; [
    tailscale
  ];
}