{pkgs, ...}: {
  # Note, volta needs to be patched by nix-ld at the system-level as home-manager cannot do it
  # Additionally, the volta package doesn't configure the required environment variables, just the completions.

  home.packages = with pkgs; [
    volta
  ];

  home.sessionVariables = {
    VOLTA_HOME = "$HOME/.cache/volta";
  };

  home.sessionPath = ["$HOME/.cache/volta/bin"];
}
