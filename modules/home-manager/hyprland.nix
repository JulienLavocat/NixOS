{lib, ...}: {
  options = {};
  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {};
    };
  };
}
