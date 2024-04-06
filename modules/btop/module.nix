{pkgs, ...}: {
  home.packages = with pkgs; [
    btop
  ];

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "TTY";
      vim_keys = true;
    };
  };
}
