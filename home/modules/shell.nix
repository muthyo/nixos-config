# Shell configuration
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Bash configuration
  programs.bash = {
    enable = true;

    # Optional: Add bash aliases, functions, etc.
    # shellAliases = {
    #   ll = "ls -la";
    #   ".." = "cd ..";
    # };
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    # Custom configuration
    settings = {
      # You can customize your prompt here
      add_newline = true;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
      };
    };
  };
}
