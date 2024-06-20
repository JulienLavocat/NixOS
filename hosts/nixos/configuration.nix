{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../modules/nixos/boot/module.nix
    ../../modules/nixos/audio/module.nix
    ../../modules/nixos/locale/module.nix
    ../../modules/nixos/nvidia/module.nix
    ../../modules/nixos/networking/module.nix
    ../../modules/nixos/users/module.nix
    ../../modules/nixos/shell/module.nix
    ../../modules/nixos/printers/module.nix
    ../../modules/gnome/module.nix
  ];

  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = ["nix-command" "flakes"];
  };

  system.stateVersion = "23.11";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    users = {"julien" = import ./home.nix;};
  };

  time.hardwareClockInLocalTime = true;

  virtualisation.docker.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      openssl
      glib
    ];
  };
}
