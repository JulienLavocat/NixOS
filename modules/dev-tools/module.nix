{pkgs, ...}: {
  home.packages = with pkgs; [
    jq
    curl
    wget
    hoppscotch
    dbeaver
  ];
}
