{...}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainbar = {
        layer = "top";
        position = "top";

        modules-left = [
          "group/options"
          "sway/workspaces"
          "sway/window#protocol"
          "sway/window#name"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "tray"
          "pulseaudio"
          "custom/gpu"
          "memory"
          "cpu"
          "temperature"
          "battery"
          "power-profiles-daemon"
          "custom/power-usage"
          "disk"
        ];

        "custom/separator" = {
          format = " ";
          tooltip = false;
        };
        "custom/options" = {
          format = "   ";
          tooltip = false;
        };

        "idle_inhibitor" = {
          format = " {icon}";
          format-icons = {
            activated = " ";
            deactivated = "󰒲 ";
          };
        };

        "custom/quit" = {
          format = " 󰗼 ";
          tooltip = false;
          on-click = "swaymsg exit";
        };
        "custom/lock" = {
          format = " 󰍁 ";
          tooltip = false;
          on-click = "swaylock";
        };
        "custom/reboot" = {
          format = "  ";
          tooltip = false;
          on-click = "/run/current-system/sw/bin/reboot";
        };
        "custom/power" = {
          format = "  ";
          tooltip = false;
          on-click = "/run/current-system/sw/bin/shutdown now";
        };

        "sway/workspaces" = {
          disable-scroll = true;
          format = "  {name}  ";
        };

        "sway/window#protocol" = {
          format = "{shell}";
          max-length = 50;
          rewrite = {
            xwayland = "<span color='#ffcccc'>   </span>";
            xdg_shell = "<span color='#ccffcc'>   </span>";
            "" = "   ᨐ ";
          };
        };
        "sway/window#name" = {
          format = "{title} ";
          max-length = 25;
          rewrite = {
            "(.*)Mozilla Firefox(.*)" = "󰈹  ";
            "(.*)nvim(.*)" = "  ";
            "(.*)Neovide(.*)" = "  ";
            "(.*)~(.*)" = "  ";
            "(.*)Alacritty(.*)" = "  ";
            "" = "";
          };
        };

        "sway/language" = {
          format = "{variant}";
          tooltip = false;
          on-click = "swaymsg input type:keyboard xkb_switch_layout next";
          rewrite = {
            "(.*)bone(.*)" = "eeeeeeeeeeee ";
            "" = "   ᨐ ";
          };
        };

        "custom/timer" = {
          exec = "/home/mia/.config/nixos/scripts/waybar-timer.sh updateandprint";
          exec-on-event = true;
          return-type = "json";
          interval = 1;
          signal = 4;
          format = "{icon} {0}";
          format-icons = {
            standby = "󰔞";
            running = "󱎫";
            paused = "󱫟";
          };
          on-click = "/home/mia/.config/nixos/scripts/waybar-timer.sh new 25 'notify-send \"Timer done!\"'";
          on-click-middle = "/home/mia/.config/nixos/scripts/waybar-timer.sh cancel";
          on-click-right = "/home/mia/.config/nixos/scripts/waybar-timer.sh togglepause";
          on-scroll-up = "/home/mia/.config/nixos/scripts/waybar-timer.sh increase 60 || /home/mia/.config/nixos/scripts/waybar-timer.sh new 1 'notify-send -u critical \"Timer expired.\"'";
          on-scroll-down = "/home/mia/.config/nixos/scripts/waybar-timer.sh increase -60";
        };

        "clock" = {
          format = "   {:%H:%M}";
          format-alt = "{:%A, %B %d, %Y} ";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          locale = "C";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#f9e2af'><b>{}</b></span>";
              days = "<span color='#ffffff'>{}</span>";
              weeks = "<span color='#e78284'>{}</span>";
              weekdays = "<span color='#eba0ac'>{}</span>";
              today = "<span color='#ff0000'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        "custom/outside-temperature" = {
          interval = 1;
          exec = "/home/mia/.config/nixos/scripts/get_weather_data.sh";
          tooltip-format = "Innsbruck Temperatur: {}°C";
          format = "T {}°C";
          tooltip = true;
        };

        "tray" = {
          icon-size = 18;
          spacing = 5;
        };

        "pulseaudio" = {
          format = "{icon} {volume:2}%";
          format-bluetooth = " {volume}%";
          format-muted = "󰝟";
          format-icons = {
            headphones = "";
            default = [
              ""
              ""
            ];
          };
          scroll-step = 5;
          on-click = "pamixer -t";
          on-click-right = "pavucontrol";
        };

        "custom/gpu" = {
          interval = 1;
          exec = "cat /sys/class/hwmon/hwmon*/device/gpu_busy_percent";
          format = "󰢮  {}%";
          tooltip = true;
        };

        "memory" = {
          interval = 1;
          format = " {}%";
        };

        "cpu" = {
          interval = 1;
          format = " {usage:2}%";
        };

        "temperature" = {
          interval = 1;
          thermal-zone = 2;
          critical-threshold = 80;
          format = "{icon} {temperatureC}°C";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "battery" = {
          interval = 1;
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-plugged = "󰂄 {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };

        "disk" = {
          interval = 60;
          format = "󰋊 {percentage_used:2}%";
          path = "/";
        };

        "custom/power-usage" = {
          exec = "/run/current-system/sw/bin/bash /home/mia/.config/nixos/scripts/get_power_usage.sh";
          format = "{}W";
          interval = 1;
        };

        "power-profiles-daemon" = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };

        "user" = {
          format = " {work_d}d {work_H}h";
          interval = 60;
          height = 20;
          width = 20;
        };

        "group/options" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 300;
            children-class = "option";
            transition-left-to-right = true;
          };
          modules = [
            "custom/options"
            "user"
            "idle_inhibitor"
            "custom/quit"
            "custom/lock"
            "custom/reboot"
            "custom/power"
          ];
        };
      };
    };

    style = ''
      * {
      	font-size: 22px;
        font-family: "HackNerdFont-Regular", monospace;
      }

      window#waybar {
      	background: rgba(0,0,0,0);
      	color: #ffffff;
      }

      #custom-options,
      #custom-quit,
      #custom-lock,
      #custom-reboot,
      #custom-power,
      #idle_inhibitor,
      #user,
      #custom-timer,
      #clock,
      #language,
      #tray,
      #custom-outside-temperature,
      #pulseaudio,
      #custom-gpu,
      #memory,
      #cpu,
      #temperature,
      #battery,
      #power-profiles-daemon,
      #custom-power-usage,
      #disk {
      	background: #1c1c1c;
      	padding: 0px 15px;
      	margin: 0 4px;
      	border-radius: 20px;
      	transition: background-color 0.2s ease;
      	transition: color 0.2s ease;
      }

      #custom-options {
      	border-radius: 20px;
      	padding-right: 5px;
      	color: #b4befe;
      }

      #user:hover,
      #idle_inhibitor:hover,
      #custom-quit:hover,
      #custom-lock:hover,
      #custom-reboot:hover,
      #custom-power:hover,
      #custom-options:hover,
      #user:hover,
      #custom-timer:hover,
      #clock:hover,
      #pulseaudio:hover,
      #custom-gpu:hover,
      #memory:hover,
      #cpu:hover,
      #temperature:hover,
      #battery:hover,
      #power-profiles-daemon:hover,
      #custom-power-usage:hover,
      #disk:hover,
      #custom-outside-temperature:hover {
      	color: #000000;
      }

      #idle_inhibitor,
      #custom-quit,
      #custom-lock,
      #custom-reboot,
      #custom-power {
      	background: #1c1c1c;
      	margin-left: 3px;
      	margin-right: 3px;
      }

      #custom-options {
      	color: #cba6f7;
      	border: 1.5px solid #cba6f7;
      	padding-left: 10px;
      }

      #user {
      	color: #b4befe;
      	border: 1.5px solid #b4befe;
      	padding-right: 20px;
      }

      #idle_inhibitor
      {
      	color: #89dceb;
      	border: 1.5px solid #89dceb;
      	padding-right: 20px;
      }

      #custom-quit {
      	color: #a6e3a1;
      	border: 1.5px solid #a6e3a1;
      	padding-right: 20px;
      }
      #custom-lock {
      	color: #f9e2af;
      	border: 1.5px solid #f9e2af;
      	padding-right: 20px;
      }
      #custom-reboot {
      	color: #fab387;
      	border: 1.5px solid #fab387;
      	padding-right: 20px;
      }
      #custom-power {
      	color: #e78284;
      	border: 1.5px solid #e78284;
      	padding-right: 20px;
      }

      #custom-options:hover {
      	background: #cba6f7;
      }
      #user:hover {
      	background: #b4befe;
      }
      #idle_inhibitor:hover {
      	background: #89dceb;
      }
      #custom-quit:hover {
      	background: #a6e3a1;
      }
      #custom-lock:hover {
      	background: #f9e2af;
      }
      #custom-reboot:hover {
      	background: #fab387;
      }
      #custom-power:hover {
      	background: #e78284;
      }

      #workspaces button {
      	padding: 0px;
      	color: #ffffff;
      	background: #1c1c1c;
      	margin-left: 4px;
      	margin-right: 4px;
      	border-radius: 20px;
      }

      #workspaces button.focused {
      	color: #000000;
      	background: #ffffff;
      }
      #workspaces button:hover {
      	color: #000000;
      	box-shadow: inherit;
      	text-shadow: inherit;
      }
      #workspaces button:nth-child(1) {
      	border: 1.5px solid #b4befe;
      }
      #workspaces button:nth-child(2) {
      	border: 1.5px solid #89dceb;
      }
      #workspaces button:nth-child(3) {
      	border: 1.5px solid #a6e3a1;
      }
      #workspaces button:nth-child(4) {
      	border: 1.5px solid #f9e2af;
      }
      #workspaces button:nth-child(5) {
      	border: 1.5px solid #fab387;
      }
      #workspaces button:nth-child(6) {
      	border: 1.5px solid #e78284;
      }
      #workspaces button:nth-child(7) {
      	border: 1.5px solid #eba0ac;
      }
      #workspaces button:nth-child(8) {
      	border: 1.5px solid #f5c2e7;
      }
      #workspaces button:nth-child(9) {
      	border: 1.5px solid #cba6f7;
      }
      #workspaces button:nth-child(10) {
      	border: 1.5px solid #ffffff;
      }
      #workspaces button.focused:nth-child(1),
      #workspaces button:hover:nth-child(1) {
      	background: #b4befe;
      }
      #workspaces button.focused:nth-child(2),
      #workspaces button:hover:nth-child(2) {
      	background: #89dceb;
      }
      #workspaces button.focused:nth-child(3),
      #workspaces button:hover:nth-child(3) {
      	background: #a6e3a1;
      }
      #workspaces button.focused:nth-child(4),
      #workspaces button:hover:nth-child(4) {
      	background: #f9e2af;
      }
      #workspaces button.focused:nth-child(5),
      #workspaces button:hover:nth-child(5) {
      	background: #fab387;
      }
      #workspaces button.focused:nth-child(6),
      #workspaces button:hover:nth-child(6) {
      	background: #e78284;
      }
      #workspaces button.focused:nth-child(7),
      #workspaces button:hover:nth-child(7) {
      	background: #eba0ac;
      }
      #workspaces button.focused:nth-child(8),
      #workspaces button:hover:nth-child(8) {
      	background: #f5c2e7;
      }
      #workspaces button.focused:nth-child(9),
      #workspaces button:hover:nth-child(9) {
      	background: #cba6f7;
      }
      #workspaces button.focused:nth-child(10),
      #workspaces button:hover:nth-child(10) {
      	background: #ffffff;
      }

      #custom-timer {
      	border: 1.5px solid #f9e2af;
      }

      #window.protocol {
      	background: #1c1c1c;
      	margin-left: 2px;
      	border: 1.5px solid #ffffff;
      	border-right: none;
      	border-radius: 20px 0px 0px 20px;
      }

      #window.name {
      	background: #1c1c1c;
      	border: 1.5px solid #ffffff;
      	border-left: none;
      	border-radius: 0px 20px 20px 0px;
      }

      #clock {
      	padding: 0px 20px 0px 20px;
      	font-family: sourcecodepronormal;
      	border: 1.5px solid #ffffff;
      	color: #ffffff;
      }

      #language {
      	padding: 0px 20px 0px 20px;
      	border: 1.5px solid #ffffff;
      	color: #ffffff;
      }

      tooltip {
      	background-color: #171717;
      	padding: 20px;
      	margin: 20px;
      	border-width: 2px;
      	border-color: #aaaaaa;
      	border-radius: 20px;
      }

      #clock:hover {
      	background: #ffffff;
      }

      #custom-outside-temperature {
      	border: 1.5px solid #cba6f7;
      }

      #custom-outside-temperature:hover {
      	background: #cba6f7;
      }

      #tray {
      	border: 1.5px solid #cba6f7;
      }
      #pulseaudio {
      	border: 1.5px solid #f5c2e7;
      }
      #custom-gpu {
      	border: 1.5px solid #eba0ac;
      }
      #memory {
      	border: 1.5px solid #e78284;
      }
      #cpu {
      	border: 1.5px solid #fab387;
      }
      #temperature {
      	border: 1.5px solid #f9e2af;
      }
      #battery {
      	border: 1.5px solid #a6e3a1;
      }
      #custom-power-usage,
      #power-profiles-daemon {
      	border: 1.5px solid #89dceb;

      }
      #disk {
      	border: 1.5px solid #b4befe;
      }

      #power-profiles-daemon {
      	margin-right: 0px;
      	padding-right: 16px;
      	border-radius: 20px 0px 0px 20px;
      	border-right: none;
      }

      #custom-power-usage {
      	margin-left: 0px;
      	padding-left: 0px;
      	border-radius: 0px 2px;
      	border-radius: 0px 20px 20px 0px;
      	border-left: none;
      }

      #custom-timer:hover {
      	background: #f9e2af;
      }
      #tray:hover {
      	background:  #cba6f7;
      }
      #pulseaudio:hover {
      background: #f5c2e7;
      }
      #custom-gpu:hover {
      background: #eba0ac;
      }
      #memory:hover {
      background: #e78284;
      }
      #cpu:hover {
      background: #fab387;
      }
      #temperature:hover {
      background: #f9e2af;
      }
      #battery:hover {
      background: #a6e3a1;
      }
      #custom-power-usage:hover,
      #power-profiles-daemon:hover {
      background: #89dceb;
      }
      #disk:hover {
      background: #b4befe;
      }
    '';
  };
}
