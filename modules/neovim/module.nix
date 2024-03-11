{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    volta
    nodejs_20
    python3
    go
    ripgrep
    lazygit
  ];
}
