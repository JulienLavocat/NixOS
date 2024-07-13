{pkgs, ...}: {
  home.packages = with pkgs; [
    python3
    go
    ripgrep
    lazygit
    gcc
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.zsh = {
    enable = true;
    initExtra = ''
      export EDITOR=nvim
    '';
  };
}
