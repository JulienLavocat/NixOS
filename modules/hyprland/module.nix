{pkgs, ...}: {
  imports = [
    ./waybar.nix
    ./dunst.nix
    ./hyprland.nix
  ];

  config = {
    home.packages = with pkgs; [
      swww
      rofi-wayland
      grim
      slurp
      wl-clipboard
      networkmanagerapplet
      krusader
      cliphist
    ];
  };
}
