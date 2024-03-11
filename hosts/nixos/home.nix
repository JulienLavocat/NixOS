{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home-manager/hyprland.nix
  ];

  fonts.fontconfig.enableProfileFonts = true;

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

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;

      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];

      shellAliases = {
        rebuild = "alejandra /etc/nixos && sudo nixos-rebuild switch --flake /etc/nixos";
        editnix = "cd /etc/nixos && nvim && alejandra .";
        edithypr = "nvim ~/.config/hypr/hyprland.conf";
        editnvim = "cd ~/.config/nvim && nvim";
      };
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
