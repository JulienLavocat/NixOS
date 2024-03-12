{pkgs, ...}: let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &
  '';
in {
  home.packages = with pkgs; [hyprland];

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
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      # binde = bind + e flag = repeat keys (https://wiki.hyprland.org/Configuring/Binds/#bind-flags)
      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      input = {
        kb_layout = "fr";
        kb_variant = "azerty";
      };

      general = {
        gaps_out = 5;
      };

      exec-once = ''${startupScript}/bin/start'';
    };
  };
}
