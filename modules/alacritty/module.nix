{pkgs, ...}: {
  home.packages = with pkgs; [
    alacritty
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      import = ["~/.config/alacritty/themes/theme.toml"];

      font = {size = 12;};
      font.normal = {
        family = "FiraCode Nerd Font Mono";
        style = "Regular";
      };

      window = {
        decorations = "None";
        startup_mode = "Maximized";
      };

      window.padding = {
        x = 7;
        y = 0;
      };
    };
  };

  home.file = {
    ".config/alacritty/themes/theme.toml" = {
      source = ./theme.toml;
    };
  };
}
