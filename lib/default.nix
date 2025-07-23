# Helper functions for the configuration
{lib, ...}: {
  # Function to conditionally import modules
  optionalModule = condition: module:
    if condition
    then [module]
    else [];

  # Function to enable a software category
  enableSoftware = categories:
    map (cat: ../../modules/software + "/${cat}.nix") categories;

  # Function to enable hardware modules
  enableHardware = hardware:
    map (hw: ../../modules/hardware + "/${hw}.nix") hardware;

  # Function to enable services
  enableServices = services:
    map (svc: ../../modules/services + "/${svc}.nix") services;
}
