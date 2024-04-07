{pkgs, ...}: {
  home.packages = with pkgs; [
    kubectl
    kubecm
    kubectx
    k9s
    stern
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      k = "kubectl";
    };
  };
}
