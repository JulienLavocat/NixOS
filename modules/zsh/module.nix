{pkgs, ...}: {
  home.packages = with pkgs; [
    zsh
    zsh-powerlevel10k
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    historySubstringSearch.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    initExtra = ''
      source $HOME/.p10k.zsh

      if [ -z "''${WAYLAND_DISPLAY}" ] && [ "''${XDG_VTNR}" -eq 1 ]; then
        dbus-run-session Hyprland
      fi


      if [ -z "$TMUX" ]
      then
        tmux attach -t main || tmux new -s main
      fi
    '';

    shellAliases = {
      rebuild = "cd /etc/nixos && git add -A && alejandra /etc/nixos && sudo nixos-rebuild switch --flake /etc/nixos";
      editnix = "cd /etc/nixos && nvim && alejandra .";
      edithypr = "nvim ~/.config/hypr/hyprland.conf";
      editnvim = "cd ~/.config/nvim && nvim";
      nixclean = "nix-store --gc && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      cd = "z";
      b64e = "echo -n $1 | base64 -w 0";
      b64d = "echo -n $1 | base64 -d";
      sopse = "sops -i -e $1";
      sopsd = "sops -i -d $1";
    };
  };

  home.file = {
    ".p10k.zsh" = {
      source = ./.p10k.zsh;
    };
  };
}
