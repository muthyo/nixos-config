{
  description = "Modular NixOS configuration";

  inputs = {
    # Core Nix inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager for user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland compositor
    hyprland.url = "github:hyprwm/Hyprland";

    # Hardware-specific optimizations
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    nixos-hardware,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    # Function to create host configurations
    mkHost = {
      hostname,
      username ? "muthyo",
      extraModules ? [],
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs hostname username;
        };
        modules =
          [
            # Host specific configuration
            ./hosts/${hostname}

            # Include common modules for all hosts
            ./hosts/common

            # Enable Hyprland from flake
            hyprland.nixosModules.default
            {programs.hyprland.enable = true;}

            # Home-Manager as a NixOS module
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {inherit inputs;};
              home-manager.users.${username} = import ./home/${username};
            }
          ]
          ++ extraModules;
      };
  in {
    # Define your NixOS configurations
    nixosConfigurations = {
      # Your current host
      nixos = mkHost {
        hostname = "nixos";
        username = "muthyo";
      };

      # Example of how to add another host in the future
      # laptop = mkHost {
      #   hostname = "laptop";
      #   username = "muthyo";
      #   extraModules = [
      #     # Add laptop-specific modules
      #     nixos-hardware.nixosModules.dell-xps-15-9500
      #   ];
      # };
    };
  };
}
