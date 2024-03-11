{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/alacritty/alacritty.nix
    ../../modules/home-manager/zsh/zsh.nix
  ];

  fonts.fontconfig.enable = true;

  home = {
    username = "julien";
    homeDirectory = "/home/julien";

    stateVersion = "23.11"; # Please read the comment before changing.

    packages = with pkgs; [
      zsh
      zsh-powerlevel10k
      volta
      nodejs_20
      python3
      go
      ripgrep
      lazygit
      waybar
      dunst
      libnotify
      swww
      alacritty
      rofi-wayland
      firefox
      grim
      slurp
      wl-clipboard
      networkmanagerapplet
      discord
      spotify
      krusader
      cliphist
      btop
      volta
      font-awesome
      (nerdfonts.override {fonts = ["FiraCode"];})
    ];
  };

  programs = {
    home-manager = {
      enable = true;
    };

    git = {
      enable = true;
      userName = "Julien Lavocat";
      userEmail = "julien.lavocat@gmail.com";
    };

    btop = {
      enable = true;
      settings = {
        color_theme = "gruvbox_dark_v2";
        vim_keys = true;
      };
    };
  };
}
