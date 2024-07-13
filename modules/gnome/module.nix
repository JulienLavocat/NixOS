{pkgs, ...}: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = false;
    desktopManager.gnome.enable = true;
  };

  hardware.pulseaudio.enable = false;

  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-photos
      gnome-tour
      gedit # text editor
    ])
    ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      gnome-terminal
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);

  home-manager.users.julien = {
    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
  };

  environment.systemPackages = with pkgs; [xclip];
}
