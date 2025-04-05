# NixOS Configuration

A modular, maintainable NixOS configuration with Hyprland, Home Manager, and support for multiple hosts.

## Structure

```
nixos-config/
├── flake.nix                 # Entry point for the NixOS configuration
├── flake.lock                # Locks input versions
├── hosts/                    # Host-specific configurations
│   ├── common/               # Common configuration for all hosts
│   │   └── default.nix       # Imports core modules needed by all hosts
│   └── nixos/                # Configuration for "nixos" host
│       ├── default.nix       # Main host-specific configuration 
│       └── hardware-configuration.nix # Hardware-specific settings
├── modules/                  # System-level modules
│   ├── system/               # Core system settings
│   │   ├── default.nix       # Imports all system modules
│   │   ├── core.nix          # Core system settings (bootloader, network, etc.)
│   │   ├── nvidia.nix        # NVIDIA-specific configuration
│   │   ├── audio.nix         # Audio settings (PipeWire, etc.)
│   │   └── fonts.nix         # Font configuration
│   ├── gui/                  # GUI environment configurations
│   │   ├── default.nix       # Imports all desktop environments
│   │   ├── gnome.nix         # GNOME-specific configuration
│   │   └── hyprland.nix      # Hyprland configuration
│   └── services/             # System services
│       ├── default.nix       # Imports all services
│       └── printing.nix      # Printing service
├── home/                     # Home Manager configuration
│   ├── default.nix           # Common home-manager configuration
│   ├── muthyo/               # User-specific configuration
│   │   ├── default.nix       # Main user configuration that imports modules
│   │   └── home.nix          # Basic home settings (packages, etc.)
│   ├── modules/              # Shared home-manager modules
│   │   ├── packages.nix      # Common packages for all users
│   │   ├── shell.nix         # Shell configuration (bash, starship)
│   │   ├── browsers.nix      # Browser configurations
│   │   ├── git.nix           # Git configuration
│   │   └── terminal.nix      # Terminal emulators (kitty)
│   ├── editors/              # Editor configurations
│   │   ├── default.nix       # Imports all editor configurations
│   │   ├── vim.nix           # Vim configuration
│   │   └── helix.nix         # Helix configuration
│   └── dotfiles/             # Dotfiles for configuration
│       ├── helix/            # Helix configuration files
│       │   └── ...
│       └── vimrc             # Vim configuration file
```

## Usage

### Building the System

To build and activate the configuration:

```bash
# Build and switch to the new configuration
sudo nixos-rebuild switch --flake .#nixos

# Build without activating (useful for testing)
sudo nixos-rebuild build --flake .#nixos

# Boot into this configuration only once
sudo nixos-rebuild test --flake .#nixos
```

### Common Tasks

#### Adding a System Package

Edit `modules/system/core.nix` and add to `environment.systemPackages`:

```nix
environment.systemPackages = with pkgs; [
  # Existing packages...
  
  # New package
  neofetch
];
```

#### Adding a User Package

Edit `home/modules/packages.nix` and add to `home.packages`:

```nix
home.packages = with pkgs; [
  # Existing packages...
  
  # New package
  spotify
];
```

#### Adding a New Service

1. Create a new file `modules/services/myservice.nix`:

```nix
{ config, lib, pkgs, ... }:

{
  services.myservice = {
    enable = true;
    # service-specific settings
  };
}
```

2. Import it in `modules/services/default.nix`:

```nix
{ config, lib, pkgs, ... }:

{
  imports = [
    ./printing.nix
    ./myservice.nix  # Add your new service
  ];
}
```

## Adding a New Host

To add a new NixOS system to the configuration:

1. Create a new host directory:

```bash
mkdir -p hosts/new-hostname
```

2. Generate hardware configuration on the new machine:

```bash
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
```

3. Create `hosts/new-hostname/default.nix`:

```nix
# Host-specific configuration for new-hostname
{ config, lib, pkgs, hostname, username, ... }:

{
  imports = [
    # Include hardware configuration
    ./hardware-configuration.nix
    
    # Import modules specific to this host
    ../../modules/gui/gnome.nix
    # Add or remove modules as needed for this host
  ];

  # Host-specific settings
  networking.hostName = hostname;
  
  # Other host-specific settings...
}
```

4. Add the new host to `flake.nix`:

```nix
nixosConfigurations = {
  # Existing hosts...
  
  # New host
  new-hostname = mkHost {
    hostname = "new-hostname";
    username = "youruser";
    extraModules = [
      # Any additional modules specific to this host
      nixos-hardware.nixosModules.dell-xps-15-9500  # Example hardware module
    ];
  };
};
```

5. Build the configuration on the new host:

```bash
sudo nixos-rebuild switch --flake /path/to/repo#new-hostname
```

## Creating a New Module

To create a new module:

1. Decide where it belongs (system, gui, services, home, etc.)
2. Create a new file in the appropriate directory
3. Import it in the corresponding `default.nix`

Example for a new VPN module:

```nix
# modules/services/vpn.nix
{ config, lib, pkgs, ... }:

{
  services.openvpn.servers = {
    myVPN = {
      config = "config /path/to/config.ovpn";
      autoStart = false;
    };
  };
  
  # Install related packages
  environment.systemPackages = with pkgs; [
    openvpn
  ];
}
```

Then add it to `modules/services/default.nix`:

```nix
imports = [
  ./printing.nix
  ./vpn.nix  # Import the new module
];
```

## Customizing Hyprland

Hyprland configuration is split between:

- System-wide settings in `modules/gui/hyprland.nix`
- User-specific settings in `home/muthyo/home.nix`

To customize keybindings or other personal preferences, edit the configuration in your user's home.nix.

## Troubleshooting

### Rollback to Previous Configuration

If something goes wrong, you can roll back to the previous generation:

```bash
# List generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Rollback to previous generation
sudo nixos-rebuild switch --rollback
```

### Common Issues

- **Missing hardware support**: Make sure your `hardware-configuration.nix` is properly imported
- **Missing packages**: Check if the package is in the correct attribute set (`pkgs`, `pkgs.unstable`, etc.)
- **Hyprland issues**: Check waybar configuration and ensure XDG portal is properly configured

## Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Nix Package Search](https://search.nixos.org/packages)
