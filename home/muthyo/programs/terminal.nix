# Terminal and shell configuration
{
  config,
  pkgs,
  ...
}: {
  # Terminal packages
  home.packages = with pkgs; [
    kitty
    tmux
    btop
    fastfetch
  ];

  # Kitty terminal configuration
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

  # Starship prompt
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
      };
    };
  };

  # Bash configuration
  programs.bash.enable = true;
}