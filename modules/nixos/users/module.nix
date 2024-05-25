{
  inputs,
  pkgs,
  ...
}: {
  users.users.julien = {
    isNormalUser = true;
    description = "Julien Lavocat";
    extraGroups = ["networkmanager" "wheel" "input" "docker"];
    packages = with pkgs; [];
    password = "changeme";
  };

  services.getty.autologinUser = "julien";
}
