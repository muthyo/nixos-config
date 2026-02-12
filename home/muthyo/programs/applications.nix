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
    (vesktop.overrideAttrs (old: {
      postFixup =
        (old.postFixup or "")
        + ''
          substituteInPlace $out/bin/vesktop \
            --replace-fail "WaylandWindowDecorations" "WaylandWindowDecorations,WebRTCPipeWireCapturer"
        '';
    }))

    # VPN
    protonvpn-gui

    # Password manager
    bitwarden-desktop
    bitwarden-cli
    proton-pass

    # Development
    claude-code
    devenv

    # Hardware tools
    solaar

    # Office suite
    libreoffice
    joplin-desktop

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
