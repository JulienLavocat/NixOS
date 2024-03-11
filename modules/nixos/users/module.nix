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

  # Enable automatic login for the user.
  services.getty.autologinUser = "julien";
}
