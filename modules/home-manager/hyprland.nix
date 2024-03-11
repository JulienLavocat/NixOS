{pkgs, ...}: let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &
  '';
in {
  options = {};
  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        "$terminal" = "alacritty";
        "$fileManager" = "krusader";
        "$menu" = "rofi -show drun -show-icons";

        bind = [
          "$mod, F, exec, firefox"
          "$mod, M, exit"
          "$mod, Q, exec, $terminal"
          "$mod, C, killactive"
          "$mod, E, exec, $fileManager"
          "$mod, V, togglefloating"
          "$mod, R, exec, $menu"
          "$mod, P, pseudo"
          "$mod, J, togglesplit"
        ];

        input = {
          kb_layout = "fr";
          kb_variant = "azerty";
        };

        exec-once = ''${startupScript}/bin/start'';
      };
    };
  };
}
