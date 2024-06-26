{pkgs, ...}: {
  home.packages = with pkgs; [
    waybar
    font-awesome
    python3
    gobject-introspection
    python3Packages.pygobject3
    python3Packages.requests
    ncdu
    pavucontrol
  ];

  home.file = {
    ".config/waybar/mediaplayer.py" = {
      source = ./mediaplayer.py;
      executable = true;
    };

    ".config/waybar/weather.py" = {
      source = ./weather.py;
      executable = true;
    };

    ".config/waybar/style.css" = {
      source = ./style.css;
    };
  };

  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 52;
        spacing = 0;
        fixed-center = true;
        exclusive = true;
        margin-top = 5;
        margin-bottom = 5;
        margin-left = 10;
        margin-right = 10;

        modules-left = [
          "hyprland/workspaces"
          "custom/media"
        ];

        modules-center = [
          "clock"
          "custom/weather"
        ];

        modules-right = [
          "cpu"
          "memory"
          "disk"
          "temperature"
          "pulseaudio"
          "network"
          "tray"
        ];

        "custom/media" = {
          format = "{icon} {}";
          escape = true;
          return-type = "json";
          max-length = 40;
          on-click = "playerctl play-pause";
          on-click-right = "playerctl stop";
          smooth-scrolling-threshold = 1;
          on-scroll-up = "playerctl next";
          on-scroll-down = "playerctl previous";
          format-icons = {
            spotify = " ";
            default = "🎜";
          };
          exec = "$HOME/.config/waybar/mediaplayer.py";
        };

        "custom/weather" = {
          format = "{}";
          tooltip = true;
          interval = 600;
          on-click = "$HOME/.config/waybar/weather.py && notify-send 'Weather updated'";
          exec = "$HOME/.config/waybar/weather.py";
          return-type = "json";
        };

        "wlr/workspaces" = {
          format = "{icon}";
          format-active = "{icon}";
          on-click = "activate";
        };

        tray = {
          icon-size = 21;
          spacing = 4;
          show-passive-items = false;
          max-length = 6;
          min-length = 6;
        };

        clock = {
          tooltip = true;
          tooltip-format = "{: %Ec}";
          interval = 1;
          format = "  {:%T}";
          max-length = 25;
        };

        cpu = {
          interval = 3;
          format = "{usage}% {icon0}{icon1}{icon2}{icon3}{icon4}";
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          on-click = "alacritty --class system_monitor -e btop";
          max-lenght = 25;
          min-length = 6;
        };

        memory = {
          format = " {percentage}%";
          interval = 1;
          on-click = "alacritty --class system_monitor -e btop";
          max-lenght = 25;
          min-length = 6;
        };

        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = ["" "" ""];
        };

        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          on-click = "alacritty --class network -e nmtui";
        };

        disk = {
          interval = 30;
          format = "󰋊 {percentage_used}%";
          path = "/";
          tooltip = true;
          tooltip-format = "HDD - {used} used out of {total} on {path} ({percentage_used}%)";
          on-click = "alacritty --class system_monitor -e ncdu";
        };

        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          scroll-step = 1;
          on-click = "pavucontrol";
          max-lenght = 25;
        };
      }
    ];
  };
}
