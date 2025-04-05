# Common packages for users
{
  config,
  lib,
  pkgs,
  ...
}: {
  # User-specific packages
  home.packages = with pkgs; [
    # OSRS
    runelite
    jdk11

    # Password manager
    bitwarden
    bitwarden-cli

    # Logitech mouse
    solaar

    # Terminal multiplexer
    tmux

    # Discord
    vesktop

    # Terminal and utilities
    btop # System monitoring
    fastfetch # System info

    # Language servers
    nil # Nix language server
    nixd # Nix language server
    alejandra # Nix formatter
    ruff # Python linter
    nodePackages.bash-language-server # Bash language server
    nodePackages.yaml-language-server # YAML language server
    marksman # Markdown language server
  ];
}
