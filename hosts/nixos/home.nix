{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/tmux/module.nix
    ../../modules/alacritty/module.nix
    ../../modules/zsh/module.nix
    ../../modules/git/module.nix
    ../../modules/btop/module.nix
    ../../modules/neovim/module.nix
    ../../modules/firefox/module.nix
    ../../modules/go/module.nix
    ../../modules/rust/module.nix
    ../../modules/zoxide/module.nix
    ../../modules/neofetch/module.nix
    ../../modules/kubernetes/module.nix
    ../../modules/dev-tools/module.nix
    ../../modules/volta/module.nix
    ../../modules/playwright/module.nix
    ../../modules/obsidian/module.nix
    ../../modules/godot4-mono/default.nix
  ];

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  home = {
    username = "julien";
    homeDirectory = "/home/julien";

    stateVersion = "23.11";

    packages = with pkgs; [
      (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
      (pkgs.callPackage ../../derivations/spacetimedb/module.nix {})
      discord
      spotify
      glxinfo
      openssl
    ];
  };
}
