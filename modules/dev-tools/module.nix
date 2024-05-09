{pkgs, ...}: {
  home.packages = with pkgs; [
    jq
    curl
    wget
    dbeaver
    insomnia
    jdk
    gnumake
    protobuf
  ];
}
