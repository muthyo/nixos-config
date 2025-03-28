# Home Manager configuration for muthyo
{ config, pkgs, inputs, lib, ... }:

{
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
    
    # Password manager
    bitwarden

    # Logitech mouse
    solaar

    # Terminal multiplexer
    tmux
    
    # Discord
    vesktop
    
    # Hyprland utilities
    wofi              # Application launcher
    mako              # Notification daemon
    swww              # Wallpaper
    waybar            # Status bar
    wl-clipboard      # Clipboard manager
    brightnessctl     # Brightness control
    pamixer           # Volume control
    grim              # Screenshot utility
    slurp             # Region selection
    
    # Terminal and utilities
    kitty             # Terminal
    btop              # System monitoring
    fastfetch         # System info

    # Language servers
    nil                               # Nix language server
    ruff                              # Python linter
    nodePackages.bash-language-server # Bash language server
    nodePackages.yaml-language-server # YAML language server
    marksman                          # Markdown language server
  ];

  # Import editor configuration
  imports = [
    ./editors.nix
  ];

  # In your home.nix
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
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

  # Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
  
    # Simplified Hyprland configuration
    settings = {
      "$mod" = "SUPER";
    
      monitor = [
        ",preferred,auto,1"
      ];
    
      exec-once = [
        "waybar"
      ];
    
      # Input configuration
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
      };
    
      # General appearance and behavior
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };
    
      # Simplified decoration section
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };
    
      # Animation settings
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
    
      # Layout settings
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
    
      # Simplified misc settings
      misc = {
        disable_hyprland_logo = true;
      };
    
      # Basic key bindings
      bind = [
        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, V, togglefloating,"
        "$mod, F, fullscreen,"
      
        # Launch applications
        "$mod, RETURN, exec, kitty"
      
        # Window navigation
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
      
        # Workspace navigation
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
      ];
    
      # Mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
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
      { path = "~/.config/git/sensitive-config"; }
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
  
  # Configure Waybar
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
  
  # This value determines the Home Manager release that your
  # configuration is compatible with.
  home.stateVersion = "24.11";
}
