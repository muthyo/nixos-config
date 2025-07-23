# Modular NixOS Configuration

## ⚠️ Disclaimer

**This is my personal NixOS configuration used for testing and experimentation.**

**WARNING**: This configuration is highly personalized and will most likely **NOT** work on your system without significant modifications. It contains hardware-specific settings, personal preferences, and experimental configurations that may break your system.

**USE AT YOUR OWN RISK**: If you choose to use any code, configurations, or ideas from this repository, you do so entirely at your own risk. I take **NO RESPONSIBILITY** for any damage, data loss, or issues that may occur from using this code.

Consider this repository as reference material only. Always understand what you're applying to your system before proceeding.

---

A clean, modular NixOS configuration that's easy to maintain and extend.

## Structure

```
nixos-config/
├── flake.nix                    # Main entry point
├── hosts/                       # Host-specific configurations
│   └── nixos/                   # Your current host
│       ├── default.nix          # Host configuration
│       └── hardware-configuration.nix
├── modules/                     # System modules
│   ├── core/                    # Essential system modules (always enabled)
│   ├── hardware/                # Hardware-specific modules
│   ├── desktop/                 # Desktop environment modules
│   ├── services/                # System services
│   └── software/                # Optional software categories
├── home/                        # Home Manager configurations
│   └── muthyo/                  # User-specific configs
│       ├── home.nix             # Main home config
│       └── programs/            # Program-specific configs
└── lib/                         # Helper functions
```

## Adding New Software

### System-wide Software

1. **Add to existing category**: Edit the appropriate file in `modules/software/`
2. **Create new category**: Create a new `.nix` file in `modules/software/` and add it to your host config

Example - Adding Docker:
```nix
# modules/software/containers.nix
{config, lib, pkgs, ...}: {
  virtualisation.docker.enable = true;
  users.users.muthyo.extraGroups = ["docker"];
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
```

Then add to `hosts/nixos/default.nix`:
```nix
../../modules/software/containers.nix
```

### User Software

Add packages to the appropriate file in `home/muthyo/programs/` or create a new program file.

## Managing Configurations

### Enable/Disable Features

Simply comment out modules in `hosts/nixos/default.nix`:

```nix
# ../../modules/software/gaming.nix  # Disable gaming
```

### GitHub Projects

To add a GitHub project as a flake input:

1. Add to `flake.nix` inputs:
```nix
my-project = {
  url = "github:user/repo";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

2. Use in your configuration:
```nix
environment.systemPackages = [ inputs.my-project.packages.${system}.default ];
```

## Quick Commands

```bash
# Rebuild system
sudo nixos-rebuild switch --flake .

# Update flake inputs
nix flake update

# Check what will change
nixos-rebuild dry-run --flake .

# Format Nix files
alejandra .
```

## Benefits

- **Modular**: Easy to enable/disable features
- **Organized**: Clear separation of concerns
- **Maintainable**: Small, focused files
- **Extensible**: Simple to add new software/features
- **Reusable**: Host configs can share modules