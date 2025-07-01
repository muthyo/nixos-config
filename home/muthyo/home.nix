# Home Manager configuration for muthyo
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "muthyo";
  home.homeDirectory = "/home/muthyo";

  # User-specific packages
  home.packages = with pkgs; [
    # OSRS
    runelite
    jdk11

    # Messaging
    signal-desktop

    # VPN
    protonvpn-gui

    # Password manager
    bitwarden
    bitwarden-cli

    # Dev tools
    claude-code
    devenv

    # Logitech mouse
    solaar

    # Terminal multiplexer
    tmux

    # Discord
    vesktop

    # music
    spotify

    # Terminal and utilities
    kitty # Terminal
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

  # Import editor configuration
  imports = [
    ./editors.nix
  ];

  # In your home.nix
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    NH_FLAKE = "/home/muthyo/nixos-config";
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    # Optional: custom configuration
    settings = {
      # You can customize your prompt here
      add_newline = true;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
      };
      # Many other customization options available
    };
  };

  programs.bash = {
    enable = true;
  };

  programs.brave = {
    enable = true;

    # Pre-installed extensions
    extensions = [
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      "chphlpgkkbolifaimnlloiipkdnihall" # OneTab
    ];
  };

  # Configure Kitty terminal
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      background_opacity = "0.95";
    };
  };

  # Configure Git
  programs.git = {
    enable = true;
    userName = "muthyo";
    includes = [
      {path = "~/.config/git/sensitive-config";}
    ];
    extraConfig = {
      core = {
        editor = "hx";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with.
  home.stateVersion = "24.11";
}
