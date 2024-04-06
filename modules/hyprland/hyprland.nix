{pkgs, ...}: let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &
    ${pkgs.wl-clipboard}/bin/wl-paste --watch cliphist store &
  '';

  powerScript = pkgs.pkgs.writeShellScriptBin "power-manager" ''
    entries="󰜉 Reboot\n󰐥 Shutdown\n󰗽 Logout\n󰒲 Suspend"

    selected=$(echo -e $entries | rofi -dmenu | awk '{print tolower($2)}')

    case "$selected" in
    logout)
      #pkill -u $USER;;
      echo "Sorry, this one is bugged, see todo list #4 for fix. Please fix it ASAP :)";;
    suspend)
      # exec systemctl suspend;;
      echo "Sorry, this one is bugged, see todo list #4 for fix. Please fix it ASAP :)";;
    reboot)
      exec systemctl reboot;;
    shutdown)
      exec systemctl poweroff;;
    esac
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
      "$clipboardHistory" = "cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy";

      bind = [
        "$mod, F, exec, firefox"
        "$mod, M, exit"
        "$mod, Q, exec, $terminal"
        "$mod, C, killactive"
        "$mod, E, exec, $fileManager"
        "$mod, K, togglefloating"
        "$mod, R, exec, $menu"
        "$mod, P, pseudo"
        "$mod, J, togglesplit"
        "$mod, V, exec, $clipboardHistory"
        "$mod, D, exec, ${powerScript}/bin/power-manager"

        # Move focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Switch workspaces
        "$mod, ampersand, workspace, 1"
        "$mod, eacute, workspace, 2"
        "$mod, quotedbl, workspace, 3"
        "$mod, apostrophe, workspace, 4"
        "$mod, parenleft, workspace, 5"
        "$mod, minus, workspace, 6"
        "$mod, egrave, workspace, 7"
        "$mod, underscore, workspace, 8"
        "$mod, ccedilla, workspace, 9"
        "$mod, agrave, workspace, 10"

        # Move active window to workspace
        "$mod SHIFT, ampersand, movetoworkspace, 1"
        "$mod SHIFT, eacute, movetoworkspace, 2"
        "$mod SHIFT, quotedbl, movetoworkspace, 3"
        "$mod SHIFT, apostrophe, movetoworkspace, 4"
        "$mod SHIFT, parenleft, movetoworkspace, 5"
        "$mod SHIFT, minus, movetoworkspace, 6"
        "$mod SHIFT, egrave, movetoworkspace, 7"
        "$mod SHIFT, underscore, movetoworkspace, 8"
        "$mod SHIFT, ccedilla, movetoworkspace, 9"
        "$mod SHIFT, agrave, movetoworkspace, 10"

        # Scratchpad workspace (Spotify, Discord, ...)
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        # Mute audio
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioPlay, exec, playerctl play-pause"
      ];

      # binde = bind + e flag = repeat keys (https://wiki.hyprland.org/Configuring/Binds/#bind-flags)
      binde = [
        # Audio / Media keys
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      bindm = [
        # Move / Resize using mouse
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      input = {
        kb_layout = "fr";
        kb_variant = "azerty";
        numlock_by_default = true;

        follow_mouse = 1;

        sensitivity = 0.15;
        accel_profile = "flat";
      };

      general = {
        gaps_out = 5;
      };

      windowrulev2 = [
        "workspace special:magic, title:^(.*Spotify.*)$"
        "workspace special:magic, title:^(.*Discord.*)$"
      ];

      exec-once = ''${startupScript}/bin/start'';
    };
  };
}
