{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/hyprland/module.nix
    ../../modules/tmux/module.nix
    ../../modules/alacritty/module.nix
    ../../modules/zsh/module.nix
    ../../modules/git/module.nix
    ../../modules/btop/module.nix
    ../../modules/neovim/module.nix
    ../../modules/firefox/module.nix
    ../../modules/go/module.nix
    ../../modules/rust/module.nix
  ];

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  home = {
    username = "julien";
    homeDirectory = "/home/julien";

    stateVersion = "23.11";

    packages = with pkgs; [
      (nerdfonts.override {fonts = ["FiraCode"];})
      discord
      spotify
      godot_4
      glxinfo
      (pkgs.callPackage ../../derivations/spacetimedb/module.nix {})
    ];
  };
}
