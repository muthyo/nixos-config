# Hyprland window manager configuration
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Hyprland is enabled through the flake.nix input

  # Add Hyprland-specific packages
  environment.systemPackages = with pkgs; [
    # Wayland utilities
    xdg-desktop-portal-hyprland
    xwayland

    # Hyprland tools and utilities
    wofi # Application launcher
    mako # Notification daemon
    swww # Wallpaper
    waybar # Status bar
    wl-clipboard # Clipboard manager
    brightnessctl # Brightness control
    pamixer # Volume control
    grim # Screenshot utility
    slurp # Region selection
  ];

  # Setup XDG portal for Hyprland
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-hyprland
  ];

  # Configure waybar at the system level
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(21, 18, 27, 0.8);
        color: #cdd6f4;
      }

      #workspaces button {
        padding: 5px;
        color: #313244;
        margin-right: 5px;
      }

      #workspaces button.active {
        color: #a6adc8;
        background: #eba0ac;
        border-radius: 10px;
      }

      #workspaces button:hover {
        background: #11111b;
        color: #cdd6f4;
        border-radius: 10px;
      }

      #clock, #battery, #pulseaudio, #network, #cpu, #memory, #tray {
        background: #1e1e2e;
        padding: 0px 10px;
        margin: 3px 0px;
        border: 1px solid #181825;
        border-radius: 10px;
      }
    '';

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;

        modules-left = ["hyprland/workspaces" "hyprland/window"];
        modules-center = ["clock"];
        modules-right = ["pulseaudio" "cpu" "memory" "network" "tray"];

        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          sort-by-number = true;
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 50;
        };

        tray = {
          spacing = 10;
        };

        clock = {
          format = "{:%I:%M %p}";
          format-alt = "{:%A, %B %d, %Y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };

        memory = {
          format = "{}% ";
        };

        network = {
          format-wifi = "{essid} ";
          format-ethernet = "Connected ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}";
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          format-muted = " ";
          format-icons = {
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };
      };
    };
  };

  # System-wide Hyprland configuration
  programs.hyprland = {
    # Additional Hyprland settings can be added here
    # These will apply to all users

    # Example of global Hyprland settings:
    # enable = true; # This is already set in flake.nix
    # xwayland.enable = true;
  };
}
