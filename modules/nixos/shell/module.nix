{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wget
    git
    curl
    unzip
    zip
    tmux
    alejandra
    zsh
  ];

  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
}
