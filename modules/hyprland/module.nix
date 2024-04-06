{pkgs, ...}: {
  imports = [
    ./waybar/module.nix
    ./rofi/module.nix
    ./dunst.nix
    ./hyprland.nix
  ];

  config = {
    home.packages = with pkgs; [
      swww
      grim
      slurp
      wl-clipboard
      networkmanagerapplet
      krusader
      cliphist
    ];
  };
}
