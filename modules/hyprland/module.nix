{pkgs, ...}: {
  imports = [
    ./waybar.nix
    ./hyprland.nix
  ];

  config = {
    home.packages = with pkgs; [
      dunst
      libnotify
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
