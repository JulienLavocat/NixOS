{pkgs, ...}: {
  home.packages = with pkgs; [
    go
    air
  ];
}
