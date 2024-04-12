{pkgs, ...}: {
  home.packages = with pkgs; [
    python3
    go
    ripgrep
    lazygit
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
