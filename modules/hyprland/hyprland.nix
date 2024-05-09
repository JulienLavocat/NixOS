{pkgs, ...}: let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &
    ${pkgs.wl-clipboard}/bin/wl-paste --watch cliphist store &
    ${pkgs.discord}/bin/discord &
    ${pkgs.spotify}/bin/spotify &
    hyprctl dispatch workspace 1
    ${pkgs.alacritty}/bin/alacritty &
    ${pkgs.firefox}/bin/firefox &
    ${pkgs.obsidian}/bin/obsidian &
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
  home.packages = with pkgs; [
    hyprland
    xorg.xlsclients
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "alacritty";
      "$fileManager" = "krusader";
      "$menu" = "rofi -show drun -show-icons";
      "$clipboardHistory" = "cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy";
      "$takeScreenshot" = "grim -g \"$(slurp)\" $HOME/Screenshots/$(date +'%s.png')";

      bind = [
        "$mod, C, killactive"
        "$mod, E, exec, $fileManager"
        "$mod, F, exec, firefox"
        "$mod SHIFT, F, fullscreen, 1"
        "$mod, J, togglesplit"
        "$mod, K, togglefloating"
        "$mod, P, pseudo"
        "$mod, Q, exec, $terminal"
        "$mod, R, exec, $menu"
        "$mod, M, exit"
        "$mod, V, exec, $clipboardHistory"
        "$mod, X, exec, ${powerScript}/bin/power-manager"
        ",Print, exec, $takeScreenshot"

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

        # Special workspaces (hub -> Discord, Spotify), (scratchpad -> Obsidian)
        "$mod, D, togglespecialworkspace, hub"
        "$mod SHIFT, D, movetoworkspace, special:hub"
        "$mod, S, togglespecialworkspace, scratchpad"
        "$mod SHIFT, S, movetoworkspace, special:scratchpad"

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
        gaps_out = "0,7,7,7";
        border_size = 0;
        "col.active_border" = "rgba(D4BE98FF)";
        "col.inactive_border" = "rgba(ebdbb211)";
      };

      decoration = {
        rounding = 10;
      };

      windowrulev2 = [
        "workspace special:hub, title:^(.*Spotify.*)$"
        "workspace special:hub, title:^(.*Discord.*)$"
        "workspace special:scratchpad, title:^(.*Obsidian.*)$"
        "workspace 2, title:^(.*Firefox.*)$"
      ];

      exec-once = ''${startupScript}/bin/start'';
    };
  };
}
