{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home-manager/hyprland.nix
  ];

  # users.users.julien.shell = pkgs.zsh;

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
    ];
  };

  programs = {
    home-manager.enable = true;

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
  };
}
