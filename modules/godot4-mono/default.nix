{pkgs, ...}: let
  godot4-mono = pkgs.callPackage ../../packages/godot4-mono/default.nix {};
in {
  home.packages = with pkgs; [
    godot4-mono
    dotnet-sdk_8
  ];
}
