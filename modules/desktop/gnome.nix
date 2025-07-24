# GNOME Desktop Environment
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable X11
  services.xserver.enable = true;

  # Enable GNOME
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Temporarily disable Wayland for better gaming compatibility
  services.displayManager.gdm.wayland = false;

  # Configure keymap
  services.xserver.xkb = {
    layout = "no,us";
    variant = "";
  };

  # Enable XDG desktop portal
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config.common.default = "*";
  };

  # Enable dbus
  services.dbus.enable = true;

  # Configure GNOME settings
  programs.dconf.enable = true;

  # Set GNOME window button layout
  # The colon separates left and right side buttons
  # Available buttons: 'close', 'minimize', 'maximize', 'menu', 'appmenu'
  services.dbus.packages = [pkgs.dconf];

  # Configure default GNOME settings
  environment.systemPackages = with pkgs; [
    dconf-editor
  ];

  # Set GNOME window button layout using systemd user service
  systemd.user.services.gnome-button-layout = {
    description = "Set GNOME window button layout";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.glib}/bin/gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'";
      RemainAfterExit = true;
    };
  };
}
