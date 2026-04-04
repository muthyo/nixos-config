# User applications
{
  config,
  pkgs,
  inputs,
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
    proton-vpn

    # Password manager
    bitwarden-desktop
    bitwarden-cli
    proton-pass

    # Development
    inputs.claude-code-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
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
    bash-language-server
    yaml-language-server
    marksman
  ];
}
