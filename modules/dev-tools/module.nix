{pkgs, ...}: {
  home.packages = with pkgs; [
    jq
    curl
    wget
    dbeaver
  ];
}
