{pkgs, ...}: {
  home.packages = with pkgs; [
    kubectl
    kubecm
    kubectx
    k9s
    stern
    fluxcd
    sops
    gnupg
    kubernetes-helm
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      k = "kubectl";
      senc = "sops --encrypt --in-place";
      sdec = "sops --decrypt --in-place";
    };
  };
}
