{
  inputs,
  pkgs,
  ...
}: {
  users.users.julien = {
    isNormalUser = true;
    description = "Julien Lavocat";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [];
  };

  services.getty.autologinUser = "julien";
}
