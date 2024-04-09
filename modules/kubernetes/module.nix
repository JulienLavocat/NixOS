{pkgs, ...}: {
  home.packages = with pkgs; [
    kubectl
    kubecm
    kubectx
    k9s
    stern
    fluxcd
    sops
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      k = "kubectl";
    };
  };
}
