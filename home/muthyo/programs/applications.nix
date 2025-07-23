# User applications
{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # OSRS
    runelite
    jdk11

    # Communication
    signal-desktop
    vesktop

    # VPN
    protonvpn-gui

    # Password manager
    bitwarden
    bitwarden-cli

    # Development
    claude-code
    devenv

    # Hardware tools
    solaar

    # Media
    spotify
    jamesdsp

    # Language servers and formatters
    nil
    nixd
    alejandra
    ruff
    nodePackages.bash-language-server
    nodePackages.yaml-language-server
    marksman
  ];
}